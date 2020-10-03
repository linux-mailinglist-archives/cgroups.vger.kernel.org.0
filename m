Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68EE281FF0
	for <lists+cgroups@lfdr.de>; Sat,  3 Oct 2020 03:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbgJCBNM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Oct 2020 21:13:12 -0400
Received: from sonic305-21.consmr.mail.sg3.yahoo.com ([106.10.241.84]:45534
        "EHLO sonic305-21.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725379AbgJCBNM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Oct 2020 21:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1601687589; bh=YiBnr4Uk8siI0dhikjlKOiXekrwpOWZKz+TPVjgu4sY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=KSLyODSv7EgP3/28ZOF1HTAc7CFIK956aKPdYyVdwYMcnwQN45bFfAFiTG891YDx5o0Rtkjeeqf7uxzPWKabuXiDBJBbCToGzrcwB9+jsSPHeqbsyxdm/s3jDxv5gybhPmstmfkjAfDxtWz2lGI2ll7JbLcFFXSM1YN/r3zPQ5bxsFaPkUD/6q92wGx9vfXnh22HasJwH26TamVw3LMD35NHMhOktxn7fLo+rWdpMXMlR9Qsyv9qfStVsCXc8UkEZ2LYQ3w4zEHxd1wi+bFW4EogBqIPhVrjZ0ogeW43pBFCTYLohsccwQPVDaMyTmqVrPlOM6omeHMt9FL6/CPG9A==
X-YMail-OSG: 2uOYPjEVM1nCw5I9czfzOi4ogLNNQnrR2VtSx0HrZsoMlNt9Hu2GiI5HhgfxrFu
 L86iiCNarUg.vdsj8Q08qpTG7QBl6zQ2GCwI9isN88GBqehogxTVQv5YljXn.g94jDsZVP8Gsx62
 1RTRix99ySt9vM4j7g1FVa4wf7.hEW1169Iq7N5yltw0ZJMELhSWgNrNq_jWjqRZIFOHDziFgcoL
 WNOcxTKWJZkR40qawd97VDR5E39HKXBlP7tISo_MCATcRLdOqAijp_3hOr_z91ZBpOCrPEn.YbdY
 DasBru..KmvigX7mkkoH0ZYTTQ7PqB62.WQQCzQ0QAYzOvkSlwHOAXr4DOv8UJnDnhj.B_xEKjTR
 4Kz09dPY_WFeXt6BGkLQl6Zd0hVG15D1PHFcuNPob7.8IwCgAIFsX6dhHi4G.hllP4q4rxYbaSe8
 evV7DY1wvfm8P4r32EvsgeUb1A0UZ0V6mMAh4a3Fz9NQYdeAFmqGjP0WfLv9N5Gk8cePVq6wpGYk
 xus.wFeaaGLBg6yuu0jigT759YPKlZDpYrk_m1B7zLe0fQ.e6254UYR2tXzwsKfUJqxYJn5Lkuem
 N67EUkdlrWLe9._7BjdkW4p51PezP2tnariBPqGNUYVi2OiWXSSsuKMfAM4TAMMD0gyz5LwuNbeM
 TmOJRpxwbe3s2zJ0Gr76jA2XlE7x3DGiU0mITTr.LkdGg8LtaIrw5edrzjR7aO1eqVks2zdRULc9
 bwPDwJz5GnR01TC70g2SK7kNgWeU4.McAcfnZaf9cJgLjmApwUegYuqL3mJwfw_fUbyil7__Gh1T
 q8aCV8acMLMGvYN11y63AHj5a7guJCYRgXzuffPn97E_h5QbwDrcb.HuCrinqEQews6DhreRhnTj
 Iimm7mUGKSinPKUDSt.30Ek9J.dBr.tX5.Kh6zQYOCCMVGUEB3OIH03aMNlWfAhkw2AeV2yQIY2M
 8gVMoOvB5dzWfAKUa9yzpzr2PUoR.HktKsrdj.GblSClC8k3vgknYU9tPMDBFVSi3kIy3EXI6Ju_
 nCqFJJ3AhaUJc7365QXNoiBTEnHr0zDhBpMAmfjAQZBjpXuL5YDlDeppK18uk1ohrtDqqlzpeLTg
 1d01Qwys7CiP7NTuxH.Km0Z8yDvgCaVTbMZSpfzQPWlGvlDHUb.NvR0HytsUYmbdiUGA3Og3YJlZ
 teZ7uo42lO5fOsJd5XveOCuHZUCYuSs3DOyZMimmMp21x4tP1gOWzpoRhKcnD48yWsBytEwn18s.
 nmGIATILbz70jljZkeE9teWF9P_ML_WDQ2uKVTZEI_b5s4bIsQ8t33PLSWPO0BGl71rnTSxYRiZ8
 sg59CS_WKYhh066XZGnS0gmZXkUfHc0Ths2KORqCXUEFFTWeRAWez_WCQMAzWJBWJnoC0dHDyg16
 3B1dRIj6aljsl82rkrkk3pOlUBVt21o.sYmsMly5T7L8RnD3GKRmz
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.sg3.yahoo.com with HTTP; Sat, 3 Oct 2020 01:13:09 +0000
Date:   Sat, 3 Oct 2020 01:13:05 +0000 (UTC)
From:   " MRS. MARYAM COMPAORE" <mrscompaoremary2222@gmail.com>
Reply-To: mrscompaoremary2222@gmail.com
Message-ID: <490053646.971644.1601687585189@mail.yahoo.com>
Subject: FORM.MRS.MARYAM C. RICHARD.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <490053646.971644.1601687585189.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16718 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

My Beloved Friend In The Lord.

Greetings in the name of our Lord Jesus  Christ. I am Mrs. Maryam C. Richar=
d, From Poland, a widow to late (MR.RICHARD BURSON from Florida , U.S.A) l =
am 51 years old and I am a converted born again Christian, suffering from l=
ong term  Cancer of the KIDNEY, from all indication my condition is really =
deteriorating and it is quite obvious that I might not live more than two (=
2) months, according to my Doctor because the cancer has gotten to a very w=
orst / dangerous stage.

My late husband and my only child died last five years ago, his death was p=
olitically motivated. My late husband was a very rich and wealthy business =
man who was running his Gold/Diamond Business here in Burkina Faso. After h=
is death, I inherited all his business and wealth. My doctors have advised =
me that I may not live for more than two (2) months, so I now decided to di=
vide the part of this wealth, to contribute to the development of the churc=
hes in Africa, America, Asia, and Europe. I got your email id from your cou=
ntry guestbook, and I prayed over it and the spirit our Lord Jesus directed=
 me to you as an honest person who can assist me to fulfill my wish here on=
 earth before I give up in live.

My late husband, have an account deposited the sum of $5.3 Million Dollars =
in BANK OF AFRICA Burkina Faso where he do his business projects before his=
 death, So I want the Sum $5.3 Million Dollars in BANK OF AFRICA Burkina Fa=
so to be release/transfer to you as the less privileged because I cannot ta=
ke this money to the grave. Please I want you to note that this fund is lod=
ged in a Bank Of Africa in Burkina Faso.

Once I hear from you, I will forward to you all the information's you will =
use to get this fund released from the bank of Africa and to be transferred=
 to your bank account. I honestly pray that this money when transferred to =
you will be used for the said purpose on Churches and Orphanage because l h=
ave come to find out that wealth acquisition without Christ is vanity. May =
the grace of our lord Jesus the love of God and the fellowship of God be wi=
th you and your family as you will use part of this sum for Churches and Or=
phanage for my soul to rest in peace when I die.

Urgently Reply with the information=E2=80=99s bellow to this My Private E-m=
ail bellow:=20

( mrscompaoremary392@gmail.com )

1. YOUR FULL NAME..........

2. NATIONALITY.................

3. YOUR AGE......................

4. OCCUPATION.................

5. PHONE NUMBER.............

BEST REGARD.
MRS.MARYAM C. RICHARD.

