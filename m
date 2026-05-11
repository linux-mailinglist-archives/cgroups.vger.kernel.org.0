Return-Path: <cgroups+bounces-15743-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDFmFpzGAWoRjwEAu9opvQ
	(envelope-from <cgroups+bounces-15743-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:07:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DCB50D56A
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AC13301C907
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 12:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C1E37AA83;
	Mon, 11 May 2026 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idsgeYUT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603AF37881F
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501102; cv=none; b=sUSW6xtiyIwECS6o1i54XItjx0ywprjKmVt/0EfAo8f5ZC4IE1Pq2Ylv1Rg8Fzh+bkDmWvCQlkZGnoKBSaa2o6ENitEgu7YY6Vg0ZnSFoMsTQsrHkJoXikGvvCTknpqa9nHW3FT+E8u+0c2q/jzO23H/dAM7+HKQX+kKWqpAsT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501102; c=relaxed/simple;
	bh=+i9nY4yS0mmOkbjwKmwBLgjJ9pvH9NuVOTXbzoovY1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c98L9A/aGzCujEsfbeP7ki9u+hdBFY6VQR/B+QVYBNHItDe8ELf/1ZfmhTEKqcDPa9vEV5eg91u/KooJ58gVKGL0Qe1SF5pHVtLIjoMUP/q24eCj+iJOK72pSR+DpRUVdLd7PPkwXfXNtEoAayNAMud4bvvNn2n4hQ7ANuxP8Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idsgeYUT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48d102471a4so41829815e9.2
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 05:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778501100; x=1779105900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cqTnF9n3Qex9jOfxNTk7/2y9GOIfeHPZuAdK9XxmLL4=;
        b=idsgeYUTnnQaeJsP7mq0J3y4XnHB8z8WZRQpeZGpl8ikv/KA9Q4NM0684iuFMn8uAa
         yjdkSlf2sXCuFnMQUCKU/tdPBm42S/pzQGWVgfjntq3P1BFvvFT0Tt4EDJGioktxsIwW
         UYhOk+0xwcSqDnUr/M2Yi1pu+SYp9EnxjoNDkOEpgQG/Ye/s4r4JBm8YvnvduiLr3o53
         vE+ShIVz5GBv19VbFR448lV4dDnxix1XfO2596CFkyBnSyBd+q1vrQ1vkyUjAg+gsVYs
         5YaVLt0WTyH2mqJ0S/EyIkQT5oHWK7pcraODrp5Xvcpvw5kwZtxGSRaENJ5cPR/VU7c9
         JLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778501100; x=1779105900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqTnF9n3Qex9jOfxNTk7/2y9GOIfeHPZuAdK9XxmLL4=;
        b=WUaHlvJ7m6HhYzebyGL+2SONc5RPZxKxgqieP9CnY69Hrx8ZDK0jlc2IZRqwyplpCe
         rQcO1GUNndbHgWBVRmj8ulca6PiQXCibMP1u8p38A9DT1VPO3t74aEnjwvBvp6d4gShz
         Lnp3xHYWBhlaaln3VlPZ12KLDIB6n4GizLnVyQV0rmp4UPtDXjzrWe2Smsf+LGeGxH1K
         UqxA1o6s64KtpvLfhflYsVNgOBd21wi3snqXEvZD9R2RIAIPoKmL1DRmRgQzBZ0z5PQI
         Y2oaguQs9U4/UX3Ua/TCry9Ih1PX+7cWFxS5oiSGm8ratnNw0fLmsvVCPNgK+A435pmd
         7tug==
X-Forwarded-Encrypted: i=1; AFNElJ8SdMo9rbGcBLT0BF+NDHOfnjYjZEgkrfc3bTiKb9jH9gRs3RDoZBHdvDR2P8Ylhpr5c1ECy22J@vger.kernel.org
X-Gm-Message-State: AOJu0YyCQl16znHb66iQXdTWTBzfglomaiVVwCJZDbc8oUzSogRhk/0T
	CnYPleuoS4XUVTO+KmYgl+KPRQ1zFxq3PlYHpAl9XuWCuCNFWFmPs80D
X-Gm-Gg: Acq92OGFzlGcsPymAoQt1dPiOBieRG6kyWg8FjNeMF2bVXDCoscK2GRbrhdG/n82iOD
	b8MafO5Siauc9a3dCc/lKmLQESO6mbjt5F37pDhzSEpPxh1FrlivxqGLLLazdC/UY9x3h1sr4nb
	MwpuSo+Hy6Q8Fels7UnkFEaZujUoVx8s43VETH0GSnWTybGMx9SvdkXuM8qCtLsKlPHBLqzLrqd
	GZA03dK8m+jlOKGKkZy+xsW4dLCLUaWf97YvU1EtxdFPktb36Ej++GNl2aLypPFVwZxmurQfHX4
	Lw8XpVl1oY35hYFGhhhVv/fwYZi8+c2eoDfu0RyFPiFqadAWw5Yh3Q9SyDRJp86HEBgAicA2GTb
	QhQRLd+motuGhdd0XXc8A41hYF7T3zI7ezyNKWJALtyiSgHuSOzejxVH3bCNKatmmFV1DWnyGPh
	v7Y0B7WLq76v61yHViX5B5CEzWFJqr02ViEUfLsTrmHhbrVJUFB4x4rzPN2J8gQ//pG/dfsRGbw
	w==
X-Received: by 2002:a05:600c:1908:b0:489:1cd2:610a with SMTP id 5b1f17b1804b1-48e6767dfa2mr228143905e9.9.1778501099495;
        Mon, 11 May 2026 05:04:59 -0700 (PDT)
Received: from fedora ([185.193.234.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491ca2fd6sm26106273f8f.30.2026.05.11.05.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:04:59 -0700 (PDT)
Date: Mon, 11 May 2026 13:04:56 +0100
From: Vishal Moola <vishal.moola@gmail.com>
To: Hongfu Li <lihongfu@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, shuah@kernel.org,
	jthoughton@google.com, seanjc@google.com, zhangguopeng@kylinos.cn,
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/cgroup: Add NULL check after malloc in
 cgroup_util.c
Message-ID: <agHF6GQg9MpwSfPa@fedora>
References: <20260511060853.1873161-1-lihongfu@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511060853.1873161-1-lihongfu@kylinos.cn>
X-Rspamd-Queue-Id: D4DCB50D56A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15743-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishalmoola@gmail.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 02:08:53PM +0800, Hongfu Li wrote:
> Add NULL checks after malloc() in three helper functions to prevent
> NULL pointer dereference on memory allocation failure.
> - cg_name()
> - cg_name_indexed()
> - cg_control()
> 
> These functions allocate memory with malloc() but previously called
> snprintf() unconditionally, which would trigger undefined behavior
> if allocation fails.
> 
> Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
> ---

Reviewed-by: Vishal Moola <vishal.moola@gmail.com>

