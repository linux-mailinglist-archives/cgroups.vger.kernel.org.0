Return-Path: <cgroups+bounces-10655-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3EBBD1F94
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 10:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEE4A4E9A1F
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 08:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442C333086;
	Mon, 13 Oct 2025 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brandexo.pl header.i=@brandexo.pl header.b="hhL+Jy+i"
X-Original-To: cgroups@vger.kernel.org
Received: from mail.brandexo.pl (mail.brandexo.pl [37.187.49.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6519517A305
	for <cgroups@vger.kernel.org>; Mon, 13 Oct 2025 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.187.49.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343360; cv=none; b=R8vcpYU0spfYAojB/OULfGTkwAfixy5kmexdCZguIwXwKsIEuWjqPtuYV6xidUXhJ9NrVCOB45rdkPehvvr7kXdc/86EV/bb+7/EYtk9T7Iq3RRY85x0fLtScnAU8XPNa91G6Z6cH2Ch3y8ye91f71Wal6fZGNIN9pzpr/5/snc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343360; c=relaxed/simple;
	bh=S/mo7cY/2HBN4T3ecXqH6roQE4hmBOwO60AKp4leie8=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=CZEJQFkD/2tbmwitC3c41+hd2gYIxPGDfrMS53Hzzk7uJACFBlS7BDQN+7PW89PaMPZwv9HxQrNBnrHGFzT+cK38WPvfgV1jeGI1f5zoA7QKb3f4E1RtEFmK1roUkXc6uFRhnC0PuxSJMt2HkXKQ8wTPA7HrZBfP/zwYwnyUaKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brandexo.pl; spf=pass smtp.mailfrom=brandexo.pl; dkim=pass (2048-bit key) header.d=brandexo.pl header.i=@brandexo.pl header.b=hhL+Jy+i; arc=none smtp.client-ip=37.187.49.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brandexo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brandexo.pl
Received: by mail.brandexo.pl (Postfix, from userid 1002)
	id 4640525579; Mon, 13 Oct 2025 10:15:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=brandexo.pl; s=mail;
	t=1760343345; bh=S/mo7cY/2HBN4T3ecXqH6roQE4hmBOwO60AKp4leie8=;
	h=Date:From:To:Subject:From;
	b=hhL+Jy+ifCPLfJ5TK3VL0f8fdDvQdsC7Md2s1Rv8mSUy6/MQ9E1acPuywQCho3kFT
	 N0CoV1HslvfWFy0b95dbf6/kvuNJYWcQlcuDqiA6DMvQeX4MM1t7u0chxYJxmtXrvE
	 7n2w+DC3wMKhYc5HF5jU2HGCC+w05ZwvNXsWZk+WGBAUv7u058qJ2gl067zDiFmYSj
	 NcoCBH9y4zW/lzN80rbXmLIMkceuSMuawf4hDnt6DErZs84EXf2eln8dbgY9GCsATV
	 oWH3JYG1rBYFO+u7kCHPLE2xvo5uxycyjT1Jk7HXRqzt9ovMPMT9KAHm+ycZ3Srz83
	 fZncMdG6VTZ3w==
Received: by mail.brandexo.pl for <cgroups@vger.kernel.org>; Mon, 13 Oct 2025 08:15:41 GMT
Message-ID: <20251013084500-0.1.jx.2b6js.0.9ciu2pdx9a@brandexo.pl>
Date: Mon, 13 Oct 2025 08:15:41 GMT
From: "Adam Robaczewski" <adam.robaczewski@brandexo.pl>
To: <cgroups@vger.kernel.org>
Subject: vPPA dla firm
X-Mailer: mail.brandexo.pl
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

widz=C4=99, =C5=BCe Pa=C5=84stwa firma nale=C5=BCy do grupy przedsi=C4=99=
biorstw o znacznym zu=C5=BCyciu energii.=20

Zajmujemy si=C4=99 wirtualnymi umowami zakupu energii (VPPA), kt=C3=B3re =
mog=C4=85 by=C4=87 interesuj=C4=85c=C4=85 opcj=C4=85 dla firm z rocznym z=
u=C5=BCyciem 3-30 GWh.=20

To rozwi=C4=85zanie pozwala na d=C5=82ugoterminowe zabezpieczenie koszt=C3=
=B3w energii (5-7 lat) przy jednoczesnym wsparciu w raportowaniu ESG.

Je=C5=9Bli temat mo=C5=BCe by=C4=87 dla Pa=C5=84stwa interesuj=C4=85cy, j=
estem do dyspozycji na rozmow=C4=99 o mo=C5=BCliwo=C5=9Bciach dopasowania=
 takiego rozwi=C4=85zania do Pa=C5=84stwa specyfiki.

Czy s=C4=85 Pa=C5=84stwo zainteresowani?


Z wyrazami szacunku.
Adam Robaczewski

