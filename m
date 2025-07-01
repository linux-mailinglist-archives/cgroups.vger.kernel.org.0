Return-Path: <cgroups+bounces-8660-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F750AEF05E
	for <lists+cgroups@lfdr.de>; Tue,  1 Jul 2025 10:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589841BC30C8
	for <lists+cgroups@lfdr.de>; Tue,  1 Jul 2025 08:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428C425EF90;
	Tue,  1 Jul 2025 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fintechinnovations.pl header.i=@fintechinnovations.pl header.b="aiUqpm7j"
X-Original-To: cgroups@vger.kernel.org
Received: from mail.fintechinnovations.pl (mail.fintechinnovations.pl [217.61.16.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D61F38B
	for <cgroups@vger.kernel.org>; Tue,  1 Jul 2025 08:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.61.16.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356964; cv=none; b=ZBtE500SJKe6G4Hp4M6dy0Ys7Q6Yxjue9ak1SLiToTKMnP2+osSN3jioH44T2GHj8saGMo+GorT585dRv4jUEKVlQgeRkyWUFX043hZXaX2psWAAGt4/MPWA0p9+m7x2pDGJokbxJigxX6f3laYO+Rg/cYT8nX1F6CmedpyVqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356964; c=relaxed/simple;
	bh=WDX2ivk1EJ1OzJMxCW9g9P9vE/ocx4hGH2sZiQjaBJY=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=IhIQCQq43ArXAUuH52+DX9/f2+sdlOjNzERrGnG1yRWXG1X7wMa8w3kN6ArlfQgSamMZteh9g+txaKBuEI4y8M25aB4Ms7SRnsdFIMJTVh+sjAv3Xt5IqqQ/R2qAlF2dH3DSENS3flkDrQkP+hQZ6klkZ2UZlQZ+mi9r6rHBb44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fintechinnovations.pl; spf=pass smtp.mailfrom=fintechinnovations.pl; dkim=pass (2048-bit key) header.d=fintechinnovations.pl header.i=@fintechinnovations.pl header.b=aiUqpm7j; arc=none smtp.client-ip=217.61.16.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fintechinnovations.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintechinnovations.pl
Received: by mail.fintechinnovations.pl (Postfix, from userid 1002)
	id BFC0884FA5; Tue,  1 Jul 2025 09:51:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=fintechinnovations.pl; s=mail; t=1751356291;
	bh=WDX2ivk1EJ1OzJMxCW9g9P9vE/ocx4hGH2sZiQjaBJY=;
	h=Date:From:To:Subject:From;
	b=aiUqpm7jsXyg2s6v8rP1fcaDqTkt5IfrHQj4fw128Jz/68i8WcAKwkYKcwDv/ALGp
	 noHMKBd4T68s3nALtz+KP0Q1dARZYWJsvfDohUCanKd6djb2qBXdg483nTAPZL9lqB
	 HPTQFi+EKgW8pJW3NjoxCJe+lB9Vv8MDu727Ph45UnyB0m7wKHNKSbJSSrmnCl1HPq
	 hUT6p3IoEw7dD3P3DgtYtCU9jpkTuI118ABU+FzSCOrYGQaTvDkRKWrkV6lM2Dc7+6
	 kWjV6o7UnfE5KK+h4cC8boYDSnbhFGk1mx1Ic/7IsRz54Q2Qt154GG/3j55Cp/JaZZ
	 eMeAcCTSCzNqw==
Received: by mail.fintechinnovations.pl for <cgroups@vger.kernel.org>; Tue,  1 Jul 2025 07:50:53 GMT
Message-ID: <20250701084500-0.1.6v.i64i.0.dz3xbul05v@fintechinnovations.pl>
Date: Tue,  1 Jul 2025 07:50:53 GMT
From: "Weronika Szust" <weronika.szust@fintechinnovations.pl>
To: <cgroups@vger.kernel.org>
Subject: Karta lunchowa
X-Mailer: mail.fintechinnovations.pl
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Szanowni Pa=C5=84stwo,

czy zastanawiali si=C4=99 Pa=C5=84stwo, jak zwi=C4=99kszy=C4=87 zadowolen=
ie pracownik=C3=B3w i jednocze=C5=9Bnie zaoszcz=C4=99dzi=C4=87 na kosztac=
h zatrudnienia?=20

Obecnie jest mo=C5=BCliwo=C5=9B=C4=87 zwolnienia z op=C5=82at ZUS a=C5=BC=
 do 450 z=C5=82 miesi=C4=99cznie na ka=C5=BCdego pracownika poprzez dofin=
ansowanie posi=C5=82k=C3=B3w.=20

Za pomoc=C4=85 karty lunch pracownicy mog=C4=85 p=C5=82aci=C4=87 w restau=
racjach, zamawia=C4=87 jedzenie online, korzysta=C4=87 z cateringu czy ro=
bi=C4=87 zakupy spo=C5=BCywcze. To doskona=C5=82e narz=C4=99dzie motywacy=
jne, kt=C3=B3re tak=C5=BCe wyr=C3=B3=C5=BCnia firm=C4=99 na rynku pracy.

Ch=C4=99tnie opowiem wi=C4=99cej na ten temat, czy mogliby=C5=9Bmy porozm=
awia=C4=87 w najbli=C5=BCszym czasie?


Pozdrawiam
Weronika Szust

