Return-Path: <cgroups+bounces-4401-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA06695964D
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 10:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D8D1C224EE
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 08:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D054188A28;
	Wed, 21 Aug 2024 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ImagineSphere.pl header.i=@ImagineSphere.pl header.b="WFaFF/LR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail.ImagineSphere.pl (mail.imaginesphere.pl [92.222.170.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE38158D8F
	for <cgroups@vger.kernel.org>; Wed, 21 Aug 2024 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.222.170.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724226363; cv=none; b=LkVwTqNxvlAsqbX103FKebr4tfCZXOEA4nS1iCx46Vhqyf87hb+S18yfExfNU6YJRfsN0Mefdu9vxeFSFMb+5SZP69i1jJ3USDDNbkMJvqhMHK5bm3ju+ZG9O0Dd1NF1GKB1s2Tn6buFSBj8RbJ7aRSt4r01duY+XfrGbwrwuBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724226363; c=relaxed/simple;
	bh=00Q5NAIur15eovFIjFWhgwqj8foRqzD4UBvU0TfwGUU=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=XV3mPFe+s7x8DLnvPY+34ZlkOW0w4zKY/SNTvO88YwEFzjgsmEJzHfKwC3wLlzDzPIj31AUqxJVv/20IMZcTHfcEPmQq8U4E1/RCurdKzbVivhjqhG7QwcAAHgdesv6Ah5Puofen/4YVeP7Al3pxTD4625/ZZCX3Nins3rPg8sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=imaginesphere.pl; spf=pass smtp.mailfrom=imaginesphere.pl; dkim=pass (2048-bit key) header.d=ImagineSphere.pl header.i=@ImagineSphere.pl header.b=WFaFF/LR; arc=none smtp.client-ip=92.222.170.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=imaginesphere.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imaginesphere.pl
Received: by mail.ImagineSphere.pl (Postfix, from userid 1002)
	id DB2DD25398; Wed, 21 Aug 2024 09:45:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ImagineSphere.pl;
	s=mail; t=1724226348;
	bh=00Q5NAIur15eovFIjFWhgwqj8foRqzD4UBvU0TfwGUU=;
	h=Date:From:To:Subject:From;
	b=WFaFF/LR8IMQvfgbQ/c2Z+W8hoKEgVarWxzhcTkscHKuTHE7x9KD9+k2u06oriJhk
	 bfVoTxYuLdqXq62LZzm76R52bazecfkME/sitZt2+eNYDaVNPlNPPRh+oav1fvypX4
	 7RzzMgL22EE7TXyCSfXxaEisMYkjNbrWIbB/OGViN1PlMg5lpk96zbi/VxBQaSfwiD
	 QS9TO/qwPO18aOF17XhAt0SeUZnE/L932424TLR5op3cBsOyJHy5JW4wTEnScw97OC
	 peCyvIMLG+IVCIfLsmJ3EhPRBmcXDe7ZOSOT8LYTHhPV6fcZwxcIrwL2NsVfkLSW2H
	 2AZTj36LKC0iw==
Received: by mail.ImagineSphere.pl for <cgroups@vger.kernel.org>; Wed, 21 Aug 2024 07:45:21 GMT
Message-ID: <20240821084500-0.1.ay.15dj7.0.c4e66c24x7@ImagineSphere.pl>
Date: Wed, 21 Aug 2024 07:45:21 GMT
From: "Szymon Jankowski" <szymon.jankowski@imaginesphere.pl>
To: <cgroups@vger.kernel.org>
Subject: Potwierdzenie przelewu
X-Mailer: mail.ImagineSphere.pl
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Witam,

Pomagamy pozyskiwa=C4=87 nowych klient=C3=B3w B2B.

Czy interesuje Pa=C5=84stwa dotarcie do nowych potencjalnych partner=C3=B3=
w oraz uruchomienie z nimi rozm=C3=B3w handlowch ?


Pozdrawiam
Szymon Jankowski

