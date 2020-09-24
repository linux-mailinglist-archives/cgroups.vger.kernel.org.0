Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39A8277B1C
	for <lists+cgroups@lfdr.de>; Thu, 24 Sep 2020 23:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgIXVf4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Sep 2020 17:35:56 -0400
Received: from sonic309-14.consmr.mail.bf2.yahoo.com ([74.6.129.124]:35951
        "EHLO sonic309-14.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725208AbgIXVfx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Sep 2020 17:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1600983352; bh=Ruh8whhsLaTTwjIXmzA3PCfAl+J0v/p4XdxCHWadIAE=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Wc9Gwj+6OPBHLXtY85zbDkcUSeTuS4OPoglEnXvIxXfpIDgd9KGYPJpLAAAZ93RhRjODwrKUUKaPChQTF8Af+Ixu1RKczRjAUsKRbM0F0fUMhauQCsz9vXg6mQO60xTV5HY6sOXtu9iRvLJYg86bseLd+8gkgdPv0RZFhEV8Bndttvr7cEc67rZIN4UQRqnkrwIIMJZjgg0t39HqJ+eVUZAqNs6R7fiQkfiihlOwnaQ/Aa07QuYlZcF6DHpepEWa5Z2EN7ztO8DkdUwTVtGq13YR3+l714TZbVprAeI1TCiUSIIPMNgK9u8Mk7g8E0Mo/I8043W+5lHgq7SfRBrv2w==
X-YMail-OSG: mfzO6QAVM1kPSzKfsOmr9GGPF39uB8zApclEgeHX.U3.Fy5DrDWiEMYFe6ViVYE
 dctnlGu5xZn663X6rUzlqWsjkMrlP5c0llWyPqkn9CsanebLw5PPk98E3eMvy5vJXZAbGCG3PpNM
 tfowepLd0QMuuF1E.PASP2Md05qad75XIHmuqu5bS1ZcU8w06JWqWRMPXbJadCgUbXSU9WJ0LzBu
 7lpL2h1bFnIwHA.P4IzdPVYP9Dp_4rOWAt7nTZ6tM2jARw7LA6.L0l.l0RurPGL.e9GyXw6LGAhn
 Gl0_dnMrzVtw7R98BmpRJ32hA6TBZGyCEDpnOYf..FQLC3asZUALEp41Tt1S6sBHjejFSExLgld1
 YdDhFJFxWuuKArgWf35uTgqM1GvCDoKKwBsqb3_9Ln1AnV0xLTR1HouqTP.s8ti2n3uTEWrG9.OJ
 Gjhz3MEHKZw2qfb8JVq86NrIZwlEMzxbUE.I825MKjlNPYZ9uq1qM1xGaQlqmuTU1aRVZ59d8Um_
 9krNosOkoR4N1gJatFH8Ps42O_gSynPMR3gQRzxDDT2Z6B_0iFWReezYMF_Cl_bDB.bBPWdYZI2G
 t1mWHg_HbLWA3cv9dF9Pgf9SORYic3l8UH8mONUOoPds1gs5gfShZ_etTvhxFZ9dHla_Rxq0WxzB
 ucAHLeYBNSSAvmwSe5mSeOtKULjNNtHfQRO6JmhjRLa3aSYV69sBLT5dYh6TLHNiOxPexcRTweLg
 vgHHGWB3cYu8rZtAWaM92fTTd_qIS_L0MkDa5MqhwsC_d6_kQq1xZdlR7mwCtZCr81EHGYkveW1i
 FrYXstUqv2VBeNcCyhu1uF.ep8mEH.Sa7SvL3iDIm3lShNuUg7O4ZlYNbpzNTKEcSPXKS3jc0hs8
 LnEVArfKeMJZuZVuftHh5b2OdnnlPROTrsHb8N3r.1PWoPMnH86QUA6ajxRsit8GWbU9i8ZNCr70
 5_EWWvJhtOPzBhAvI02YdomZ9liB3EHCzNRzPtM2zFV.DFA7t1cKWMVO.Bg.qPs.TQ503IBHz95M
 MNRccsQHAqjQzQcf1NwfsBql_CCX.Jl4BLh5ru1M0Oi3wIXk.S1bxOtUKAP70V9W9p8451PfyEbV
 NXyCl8r5sWfxi0O5cLGWUCl2Vy9WcfnT_29UJcZLtQI7mToldw6itfQvbZOTcOjHAvaeFP3i62fj
 7i4XqEIwJq_fAg3RmjAJrzQaDAPfBQxTr0_RM4NuwlsUE4FSn7zsJecWQc0GunbHpDLYL6x2afiG
 mzJWM2.JbZHTCaD5fwajyDrNq.unvNcPJjCOmzhmeQjnbDO4jJIG_F5ERu.Df1tJtJIM7tADnTHY
 iBGSGC844mD_nBu1jq_.hEozU7bSDFTp6hb0xp070oUKAT5z6PtEVGjRd5Tq61E0ISSFOYJcFaP2
 PpXIYJ9Ywb8rGnEMjLRTL9acHZsoQBcydZDrLQc1O
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Thu, 24 Sep 2020 21:35:52 +0000
Date:   Thu, 24 Sep 2020 21:35:29 +0000 (UTC)
From:   Ms Theresa Heidi <james29234@gmail.com>
Reply-To: mstheresaaheidi@yahoo.com
Message-ID: <2084395657.463608.1600983329094@mail.yahoo.com>
Subject: =?UTF-8?B?5Yy76Zmi55qE57Sn5oCl5biu5Yqp77yB?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <2084395657.463608.1600983329094.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16674 YMailNodin Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dear Beloved One,=20

 CHARITY DONATION Please read carefully, I know it is true that this letter=
 may come to you as a surprise. nevertheless,i humbly ask you to give me yo=
ur attention and hear me, i am writing this mail to you with heavy sorrow i=
n my heart,i have chose to reach you through Internet because it still rema=
ins the fastest medium of communication after going through your profile.

My name is Mrs Theresa Heidi i am native France currently hospitalized in a=
 private hospital here in Israel as a result of lungs cancer I am 62 years =
old and I was diagnosed of lungs cancer for about 4 years ago, immediately =
after the death of my husband, who has left me everything he worked for. I'=
m with my laptop in a hospital here in where I have been undergoing treatme=
nt for cancer of the lungs

Now that is clear that I=E2=80=99m approaching the last-days of my life and=
 i don't even need the money again for any thing and because my doctor told=
 me that i would not last for the period of one year due to Lungs cancer pr=
oblem.I have some funds inherited from my late husband, the sum of $15 Mill=
ion United State Dollars ( US$15,000,000,00 ),This money is still with the =
foreign bank and the management just wrote me as the true owner to come for=
ward to receive the money for keeping it so long or rather issue a letter o=
f authorization to somebody to receive it on my behalf since I can't come o=
ver because of my illness or they may get it confiscated.

I need you to help me withdraw this money from the foreign bank then use th=
e funds for Charity works/assistance to less privileged people in the socie=
ty.It is my last wish to see that this money is invested to any organizatio=
n of your choice.

I decided to contact you if you may be willing and interested to handle the=
se trust funds in good faith before anything happens to me.This is not a st=
olen money and there are no dangers involved, is 100% risk free with full l=
egal proof.

I want you to take 45 percent of the total money for your personal use whil=
e 55% of the money will go to charity. I will appreciate your utmost confid=
entiality and trust in this matter to accomplish my heart desire, as I don'=
t want anything that will jeopardize my last wish.
       =20
Yours Beloved Sister.
Mrs Theresa Heidi
