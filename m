Return-Path: <cgroups+bounces-4538-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3970D9623C5
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 11:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA507282792
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 09:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADF2166312;
	Wed, 28 Aug 2024 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=unitytrustfinancial.com header.i=@unitytrustfinancial.com header.b="bFQK/Jyp"
X-Original-To: cgroups@vger.kernel.org
Received: from globelaneexpress.com (globelaneexpress.com [31.220.3.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADCE16132F
	for <cgroups@vger.kernel.org>; Wed, 28 Aug 2024 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.220.3.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838104; cv=none; b=WJMc80zJR2dsAp+qgKiluI//yYLebTyJDSMZcAQy82O8UVxZ5cgrvfnZOPNMG28B7iqaqov/pzX/k4kUeqX6ZDw+s7HF9iDqRYyv7YL7DVXduVboSuJ2sFM8/PC9TTZdZWXp4pG55H+ict07lftVrve4ntmVyamrXeUWP14Ziqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838104; c=relaxed/simple;
	bh=jGlQjVgShWaVNPBUuyRUOk56Om/DWzPsx99tbSnuIvE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jl5v4U+pXYzr05gmlWMhJ037iGAVleakXtA3MMcJ5FljnNq8phZuM2MjG39+yopiqnDnzxatUbGn9qCR8m/m7etasUj/3/AAzJVtB/nbhckuhWAYKgTts3tG40+WHxyLRZwdjzvOVo4Y3d7jaSUPbcKiIGDa+u+V2RXQDmisZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unitytrustfinancial.com; spf=pass smtp.mailfrom=unitytrustfinancial.com; dkim=pass (2048-bit key) header.d=unitytrustfinancial.com header.i=@unitytrustfinancial.com header.b=bFQK/Jyp; arc=none smtp.client-ip=31.220.3.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unitytrustfinancial.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unitytrustfinancial.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=unitytrustfinancial.com; s=default; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OhbKwx+DBwme6pCk0eKZ/IMpViUnoaxYBuEZkAtNlfE=; b=bFQK/JypFeqkgOS6H45hXrv3L7
	On7qVqhDvesTAeYVivydUeI6C3kZL03wEBhyU7GttrTg0FxhquNkkWNIe0rRSh5fOIBFI9mS/Niwb
	ugQIVstsslu9D1866CNLBjzMpaNXLqZEmr16GgrmD1K4M7M8chTan/IP8Fe6tjjYHKLYy+YkudAK+
	zXhNZCUy3/nM20esSh/hErA9hqBkXT4bsKKUZJ5r97R2/2J6fg+RRbuBov3YOMhv7VjVCKCNSNe3q
	NIZWeNjagzBh8dQksYKJErl7fqhUQayVWbriVigfTTB1hA3y5IUe8rPAf5Ma1c26masUTsMfw24bn
	5YZ5arwg==;
Received: from [84.38.132.26] (port=49603)
	by nl6.nlkoddos.com with esmtpa (Exim 4.96.2)
	(envelope-from <inquiry@unitytrustfinancial.com>)
	id 1sjFB2-00CqJH-35
	for cgroups@vger.kernel.org;
	Wed, 28 Aug 2024 11:41:36 +0200
Reply-To: vivian@internationaluniforms.com
From: Vivian <inquiry@unitytrustfinancial.com>
To: cgroups@vger.kernel.org
Subject: Request For Inquiry
Date: 28 Aug 2024 12:41:36 +0300
Message-ID: <20240828124136.57A52F04EA483ED1@unitytrustfinancial.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nl6.nlkoddos.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - unitytrustfinancial.com
X-Get-Message-Sender-Via: nl6.nlkoddos.com: authenticated_id: inquiry@unitytrustfinancial.com
X-Authenticated-Sender: nl6.nlkoddos.com: inquiry@unitytrustfinancial.com

Dear Supplier

Nice to contact you again
Hope this mail find you well

We are interested in importing your product
i would like to place an order from your company this month,

kindly send me your catalogue and price through our E-MAIL or=20
skype,
Please treat this as urgent

thanks

Purchase Manager vivian

Email: vivian@internationaluniforms.com
Beim Strohhause 2
20097 Hamburg =E2=80=93 Germany
Phone:  +49/40/284 24-321
Fax:  +49/40/284 24-236

