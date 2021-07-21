Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32A03D1949
	for <lists+cgroups@lfdr.de>; Wed, 21 Jul 2021 23:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhGUUxA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Jul 2021 16:53:00 -0400
Received: from [175.7.199.234] ([175.7.199.234]:41170 "EHLO 1ndax.top"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S229625AbhGUUw7 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 21 Jul 2021 16:52:59 -0400
X-Greylist: delayed 1202 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Jul 2021 16:52:59 EDT
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=1ndax; d=1ndax.top;
 h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=etc-maisei@1ndax.top;
 bh=26/9kiHV4VR/kj+AVOueDcIM+tM=;
 b=ikqPEDuQLLDcflGvKaaLWU3JcSAmAvsO78/LNWnFXdo1bhPfvCWPyLVHjzX6nkCcRlpiR31YVQKu
   kAKeko5HuJar5Ljf5tx4APqzClzo7IV7JfWQv72wica+pn5LoOPkQYB6p3mUywO6YLvTJoEYu5oJ
   oFOo4dqqI2SZKvGgfV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=1ndax; d=1ndax.top;
 b=aiVhJXhSjL6RlUuDeSI0Fm+DirOFj0BjU0oQB5aVepdKRdXwoMCylPHWw7e1hAx3HGqPvz8uq00a
   YIQxQWWZkzsBJDQzXFIajEcgEgNrDgqcOhYHGOLAw/NNAlMMMYPENHLt3vegkrgoiglB0ge9SgbV
   O9UA+3i0iUMFZ7/d7xA=;
Message-ID: <C06AA08BDAEA8A57744031216E7C2734@wklawegq>
From:   =?utf-8?B?RVRD5oOF5aCx?= <etc-maisei@1ndax.top>
To:     <cgroups@vger.kernel.org>
Subject: =?utf-8?B?44K144O844OT44K56YCa55+l?=
Date:   Thu, 22 Jul 2021 05:13:12 +0800
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

RVRD44K144O844OT44K544KS44GU5Yip55So44Gu44GK5a6i5qeYOg0KDQoNCkVUQ+OCteODvOOD
k+OCueOBr+eEoeWKueOBq+OBquOCiuOBvuOBl+OBn+OAgg0K5byV44GN57aa44GN44K144O844OT
44K544KS44GU5Yip55So44GE44Gf44Gg44GN44Gf44GE5aC05ZCI44Gv44CB5LiL6KiY44Oq44Oz
44Kv44KI44KK6Kmz57Sw44KS44GU56K66KqN44GP44Gg44GV44GE44CCDQoNCg0K5LiL6KiY44Gu
5o6l57aa44GL44KJ5YGc5q2i5Y6f5Zug44KS56K66KqN44GX44Gm44GP44Gg44GV44GEDQpodHRw
czovL2V0Yy1tZWxmYWktanAucmFkaW8uYW0NCg0KKOebtOaOpeOCouOCr+OCu+OCueOBp+OBjeOB
quOBhOWgtOWQiOOBr+OAgeaJi+WLleOBp+ODluODqeOCpuOCtuOBq+OCs+ODlOODvOOBl+OBpumW
i+OBhOOBpuOBj+OBoOOBleOBhCkNCg0KDQoNCuKAu+OBk+OBruODoeODvOODq+OBr+mAgeS/oeWw
gueUqOOBp+OBmeOAgg0K44CA44GT44Gu44Ki44OJ44Os44K544Gr6YCB5L+h44GE44Gf44Gg44GE
44Gm44KC6L+U5L+h44GE44Gf44GX44GL44Gt44G+44GZ44Gu44Gn44CB44GC44KJ44GL44GY44KB
44GU5LqG5om/6aGY44GE44G+44GZ44CCDQrigLvjgarjgYrjgIHjgZTkuI3mmI7jgarngrnjgavj
gaTjgY3jgb7jgZfjgabjga/jgIHjgYrmiYvmlbDjgafjgZnjgYzjgIENCsOLVEPjgrXjg7zjg5Pj
grnkuovli5nlsYDjgavjgYrllY/jgYTlkIjjgo/jgZvjgY/jgaDjgZXjgYTjgIINCg0KDQoNCuKW
oEVUQ+WIqeeUqOeFp+S8muOCteODvOODk+OCueS6i+WLmeWxgA0K5bm05Lit54Sh5LyR44CAOTow
MO+9njE4OjAwDQrjg4rjg5Pjg4DjgqTjg6Tjg6vjgIAwNTcwLTAxMDEzOQ0K77yI44OK44OT44OA
44Kk44Ok44Or44GM44GU5Yip55So44GE44Gf44Gg44GR44Gq44GE44GK5a6i44GV44G+44CAMDQ1
LTc0NC0xMzcy77yJDQo=


