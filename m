Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F8B203B5A
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2020 17:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgFVPqi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Jun 2020 11:46:38 -0400
Received: from sonic316-20.consmr.mail.ne1.yahoo.com ([66.163.187.146]:37385
        "EHLO sonic316-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729247AbgFVPqi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Jun 2020 11:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1592840797; bh=ac0sCjJUI93cXt8Ne4UV+BUmdTO8c8UeaDLEdPti3zY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=trNIpPZZjnb9Pldg6H3GJc36pWlIwhI/kFDsT301YkO6vknY6qoWD5dkEBo2oR8lblmVumpWXyHzmCSrtveGwPTbnJ8IYgfkBEndOnb0/k62hYf0RHVc57ozUepCcOAZQUr0T0TRp8PhN7nnUEQAO86wPocCFjZyMx34LFRx73xJbVG0ovy6DUq6RB4+U3hS3fgLsvzOhenEHV6KBdaTVmUDMKf4S5nM6IZzfE+bVHR1inH9v1074l4o06vnBBtFtoxpXpzRTOjX59WwKmeNo5d66llgNk2aErMyjBbiAEL6eIn5xBLYSFrd1C9417dIpVkbhDnQwatxfomI1RwwEQ==
X-YMail-OSG: k4hy6bgVM1lU.cgX36qUEK57IfKWSuwO6GpFAyrvgM1gjsORWOs4en6kfkerMau
 ZcOxL3gSZm4F2JDNgMACC1qtTb7wm7UBpGYLq2HeWlQKbPGlkhYd3UrqAhS6X666sAx_72aDNgGM
 K.Lh6AdFoLAsbfQp6rerbe265p_qhn8F14PZrl_ruQ3xxOiRQImNXPtLDrv.scVtdg0Q.Z9UvVNd
 aAsRo4.mPSi49JAY_uF8zuishjbeB74.037sOxx8IaMmh6X104sMtTEdoPJ5oRbjSSfRI5drTa.I
 SH3OOpp7ra9x6coMA8oVzzyii0dYiIID1T8m3MrEsZv0hvKZXPSF8XO2tazlMWoTddwx4CPViy1y
 u3oFjwU8gWTbh9t0foyIWSZjTdJVdIK.4lly9t22vFQbqZ2g4N4zpQhnfRLAhPf0fE5OfKGo9_Sg
 ypUam.pnaiF1TNC7tUW60eBzFPlhc9I_2HgX6y5nGeqG4G8Xsow3wur9xH.18zTgU_ruHVU3nhzM
 tGXLBT1uPhzrEjesomejMXUJKgGOSJRMaPon5ZQbxwaOhExqm9ardNkdCqJ5SgrcEECux1JNTREw
 xFK0IyneE4nMDRiDz_Y5vaAIfgPC8q7emBJwAkttGrUXulrB_qhTezbt0A8EOgZ4n2NduLG7KIhf
 J_rcn7eZjhcBb9UhSgNJWqpD5omVHgZOvTGReMfTP_zSMrueQcvNlk3GpZ7fqrdyFHR9XunlqL25
 9.WMuIrLbWjQvugxqyU9DF4b9k3itppvruEYl3SnHRCIMnlWifN9imE3k5muE2.mzLZXSaiLsAf7
 AVsAneI5fRGaZmzl8UwwVhbpJlcPLw9d3n0BQHaC66Itu2ZfCbHfT5QnF1V7ij5jAVtxkF7VtE6v
 PN1MI5AGx4xIjZRHB2o6E9EtF5irMogLWdGggNa8bsSl4VVGHlgO_i1fYpJ.3MOUqwYZ2RRO4_Vx
 MXhfFt5LuhTYEVrnajeVRhSzaCApr1.bJSDzcXeHcmzFLPuU46zNUrA7zTejk17n9P01bYlbSztn
 OuOmyhl8vi33ndYn4RQZR4_4q3iKRXzcZPwwFT8kkMyKb5IiRjoJgwdn7lurPYDoBC4DLXRINJ6Y
 KODUNGJvdNr8I0hD.KzqxxwBGQw.bdmtpKwFG0ZTPxsi6o5Ipga0MAje0vBUF2pAiAjGr.qMiLVx
 ylS9cFmyBXptoPRD.0qb9ucwcQizmYNhDHvL0F9Vn2.VTr1XnudeyNH5omqZumV48MLteYMO5gnq
 d0_J9guqnNPRA.mlGCAKRh5OxFlS9o2zX_PESv51g18bNN.Vrb63DCFU1wBRuMmOjMv6m57d6RzL
 VlPDs4k8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Jun 2020 15:46:37 +0000
Date:   Mon, 22 Jun 2020 15:46:33 +0000 (UTC)
From:   Karim Zakari <kariim1960z@gmail.com>
Reply-To: kzakari04@gmail.com
Message-ID: <333757312.1852569.1592840793061@mail.yahoo.com>
Subject: URGENT REPLY.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <333757312.1852569.1592840793061.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16138 YMailNodin Mozilla/5.0 (Windows NT 6.1; ) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



Good-Day=C2=A0Friend,

=C2=A0Hope=C2=A0you=C2=A0are=C2=A0doing=C2=A0great=C2=A0Today.=C2=A0I=C2=A0=
have=C2=A0a=C2=A0proposed=C2=A0business=C2=A0deal=C2=A0worthy=C2=A0(US$16.5=
=C2=A0Million=C2=A0Dollars)=C2=A0that=C2=A0will=C2=A0benefit=C2=A0both=C2=
=A0parties.=C2=A0This=C2=A0is=C2=A0legitimate'=C2=A0legal=C2=A0and=C2=A0you=
r=C2=A0personality=C2=A0will=C2=A0not=C2=A0be=C2=A0compromised.

Waiting=C2=A0for=C2=A0your=C2=A0response=C2=A0for=C2=A0more=C2=A0details,=
=C2=A0As=C2=A0you=C2=A0are=C2=A0willing=C2=A0to=C2=A0execute=C2=A0this=C2=
=A0business=C2=A0opportunity=C2=A0with=C2=A0me.

Sincerely=C2=A0Yours,
Mr.=C2=A0Karim=C2=A0Zakari.
