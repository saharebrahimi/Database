---1

SELECT     cm.CustomerID, cm.CompanyID, cm.CUserName,cm.CName, cm.CSname, cm.CNationalCode
FROM         dbo.tblCustomers AS cm INNER JOIN dbo.tblAccountsPayOrdersDetailSignatures 
AS Ag ON cm.CustomerID = Ag.SignedByID
GROUP BY cm.CustomerID, cm.CompanyID, cm.CUserName, cm.CName, cm.CSname, cm.CNationalCode


---2

SELECT     tblAccounts_1.AccID, tblAccounts_1.AccNumber, tblAccounts_1.SignQuantity, M1.Tedad AS TedadeEmzaDaran
FROM         (SELECT     AccID, Tedad
                        FROM
						(SELECT     TOP (100) PERCENT dbo.tblAccounts.AccID, dbo.tblAccessLevelsTypes.AccessLevelsTypeID, dbo.tblAccessLevelsTypes.AccessLevelsDesc,COUNT(dbo.tblAccessLevelsTypes.AccessLevelsDesc) AS Tedad
                        FROM    dbo.tblAccessLevelsTypes INNER JOIN dbo.tblAccountsOwnersAccessLevels ON 
                                                                      dbo.tblAccessLevelsTypes.AccessLevelsTypeID = dbo.tblAccountsOwnersAccessLevels.AccessLevelID INNER JOIN
                                                                      dbo.tblAccountsOwners ON dbo.tblAccountsOwnersAccessLevels.AccOwnerID = dbo.tblAccountsOwners.AccOwnerID INNER JOIN
                                                                      dbo.tblAccounts ON dbo.tblAccountsOwners.AccID = dbo.tblAccounts.AccID
                        GROUP BY dbo.tblAccounts.AccID, dbo.tblAccessLevelsTypes.AccessLevelsTypeID, dbo.tblAccessLevelsTypes.AccessLevelsDesc
                        HAVING      (dbo.tblAccessLevelsTypes.AccessLevelsTypeID = 1)) AS SignHa) AS M1 RIGHT OUTER JOIN
												dbo.tblAccounts AS tblAccounts_1 ON M1.AccID = tblAccounts_1.AccID
WHERE     (M1.Tedad > tblAccounts_1.SignQuantity)


---3


SELECT     M.PayOrderID, M.AccID, M.Expr1, M.IsPaid, dbo.tblAccounts.SignQuantity
FROM         (SELECT     dbo.tblAccountsPayOrders.PayOrderID, dbo.tblAccountsPayOrders.AccID, COUNT(dbo.tblAccountsPayOrdersDetailSignatures.PayOrderID) AS Expr1,dbo.tblAccountsPayOrders.IsPaid
                        FROM         dbo.tblAccountsPayOrders INNER JOIN
                                              dbo.tblAccountsPayOrdersDetailSignatures ON dbo.tblAccountsPayOrders.PayOrderID = dbo.tblAccountsPayOrdersDetailSignatures.PayOrderID
                        WHERE     (dbo.tblAccountsPayOrders.IsPaid = 0)
                        GROUP BY dbo.tblAccountsPayOrders.AccID, dbo.tblAccountsPayOrders.IsPaid, dbo.tblAccountsPayOrders.PayOrderID) AS M INNER JOIN
                      dbo.tblAccounts ON M.AccID = dbo.tblAccounts.AccID AND M.Expr1 >= dbo.tblAccounts.SignQuantity

					  
----4


SELECT     derivedtbl_1.PayOrderID, derivedtbl_1.AccID, derivedtbl_1.Expr1, derivedtbl_1.IsPaid, derivedtbl_1.SignQuantity, 
                      dbo.tblAccountsPayOrdersDetail.PayOrderID AS Expr2, dbo.tblAccountsPayOrdersDetail.DestinationAccID, dbo.tblAccountsPayOrdersDetail.OrderAmout, 
                      dbo.tblAccountsPayOrdersDetail.IsDeposit, tblAccounts_1.AccNumber
FROM         (SELECT     M.PayOrderID, M.AccID, M.Expr1, M.IsPaid, dbo.tblAccounts.SignQuantity
                        FROM         (SELECT     dbo.tblAccountsPayOrders.PayOrderID, dbo.tblAccountsPayOrders.AccID, COUNT(dbo.tblAccountsPayOrdersDetailSignatures.PayOrderID) 
                                                                      AS Expr1, dbo.tblAccountsPayOrders.IsPaid
                                                FROM         dbo.tblAccountsPayOrders INNER JOIN
dbo.tblAccountsPayOrdersDetailSignatures ON 
dbo.tblAccountsPayOrders.PayOrderID = dbo.tblAccountsPayOrdersDetailSignatures.PayOrderID
  WHERE     (dbo.tblAccountsPayOrders.IsPaid = 0) GROUP BY dbo.tblAccountsPayOrders.AccID, dbo.tblAccountsPayOrders.IsPaid, dbo.tblAccountsPayOrders.PayOrderID) AS M INNER JOIN
  dbo.tblAccounts ON M.AccID = dbo.tblAccounts.AccID AND M.Expr1 >= dbo.tblAccounts.SignQuantity) AS derivedtbl_1 INNER JOIN
dbo.tblAccountsPayOrdersDetail ON derivedtbl_1.PayOrderID = dbo.tblAccountsPayOrdersDetail.PayOrderID INNER JOIN dbo.tblAccounts AS tblAccounts_1 ON  dbo.tblAccountsPayOrdersDetail.DestinationAccID = tblAccounts_1.AccID
WHERE     (tblAccounts_1.AccNumber = N'465465464')



----5


SELECT PayOrderDetailSignID,SignedByID,PayOrderID,LogType,LogDateTime
 FROM tblAccountsPayOrdersDetailSignatures_Logs
 WHERE LogType = 1 AND SignedByID = 100077

  
----6

SELECT     acc.AccID, acc.AccNumber
FROM         dbo.tblAccounts AS acc INNER JOIN
dbo.tblAccountsOwners AS aco ON acc.AccID = aco.AccID INNER JOIN
dbo.tblCustomers AS cm ON aco.CustomerID = cm.CustomerID
WHERE     (cm.CustomerID = 100000)

INTERSECT

SELECT     acc.AccID, acc.AccNumber
FROM         dbo.tblAccounts AS acc INNER JOIN
 dbo.tblAccountsOwners AS aco ON acc.AccID = aco.AccID INNER JOIN
 dbo.tblCustomers AS cm ON aco.CustomerID = cm.CustomerID
WHERE     (cm.CustomerID = 100042)

----7

SELECT     PayOrders.AccID, PayOrders.AccNumber, PayOrders.CustomerID, PayOrders.PayOrderID, PayOrders.CNationalCode, PayOrders.TotalAmount
FROM         (SELECT     dbo.tblAccounts.AccID, dbo.tblAccounts.AccNumber, dbo.tblCustomers.CustomerID, dbo.tblAccountsPayOrders.PayOrderID, dbo.tblAccountsPayOrders.CNationalCode,  dbo.tblAccountsPayOrders.TotalAmount FROM         dbo.tblAccountsOwners INNER JOIN dbo.tblAccounts ON dbo.tblAccountsOwners.AccID = dbo.tblAccounts.AccID INNER JOIN dbo.tblCustomers ON dbo.tblAccountsOwners.CustomerID = dbo.tblCustomers.CustomerID INNER JOIN
dbo.tblAccountsPayOrdersDetailSignatures ON dbo.tblCustomers.CustomerID = dbo.tblAccountsPayOrdersDetailSignatures.SignedByID INNER JOIN
dbo.tblAccountsPayOrders ON  dbo.tblAccountsPayOrdersDetailSignatures.PayOrderID = dbo.tblAccountsPayOrders.PayOrderID) AS PayOrders INNER JOIN
(SELECT     TOP (100) PERCENT tblAccounts_2.AccID, tblAccounts_2.AccNumber, tblAccountsOwners_1.CustomerID, dbo.tblAccessLevelsTypes.AccessLevelsTypeID, 
dbo.tblAccessLevelsTypes.AccessLevelsDesc FROM         dbo.tblAccounts AS tblAccounts_2 INNER JOIN dbo.tblAccountsOwners AS tblAccountsOwners_1 ON tblAccounts_2.AccID = tblAccountsOwners_1.AccID INNER JOIN
dbo.tblAccountsOwnersAccessLevels ON tblAccountsOwners_1.AccOwnerID = dbo.tblAccountsOwnersAccessLevels.AccOwnerID INNER JOIN
dbo.tblAccessLevelsTypes ON dbo.tblAccountsOwnersAccessLevels.AccessLevelID = dbo.tblAccessLevelsTypes.AccessLevelsTypeID WHERE     (dbo.tblAccessLevelsTypes.AccessLevelsTypeID = 1)) AS tblAccounts_1 ON PayOrders.AccID = tblAccounts_1.AccID GROUP BY PayOrders.AccID, PayOrders.AccNumber, PayOrders.CustomerID, PayOrders.PayOrderID, PayOrders.CNationalCode, PayOrders.TotalAmount 
HAVING      (PayOrders.CustomerID = 100000) 

----8

SELECT * , dbo.GetIsThatUserHasSignLevel (fd.CreatedByID , fd.AccID) AS SignLevel FROM [tblAccountsPayOrders] fd WHERE fd.CreatedByID = 100064 and dbo.GetIsThatUserHasSignLevel (fd.CreatedByID , fd.AccID) = 0  

----9

SELECT     Acc.AccID, Acc.AccNumber, Acb.Price
FROM         dbo.tblAccountsBill AS Acb INNER JOIN
                      dbo.tblAccounts AS Acc ON Acb.AccID = Acc.AccID
WHERE     (Acc.AccNumber = N'100000015') AND (Acb.Price > 2000)
