Return-Path: <cgroups+bounces-16460-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB28NoXwGWoX0AgAu9opvQ
	(envelope-from <cgroups+bounces-16460-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 22:01:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C0B608290
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 22:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C92DE3054F55
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 19:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9083D8104;
	Fri, 29 May 2026 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6znuUZS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77593939CE
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084704; cv=pass; b=psW1oBm1sEo4g7mJ6j5cVcztQwkfFsN3n7vVpW9SMIp713ybQ4jmRiDxI9VsRauQZ9WHtiohIzzKwgNcgHX/o2/Yl/0WXwB3Uei9KYaUqvuF9Mi8a2vwi90C+h2UeiA1XnPkg0m5RK3e5l6NnpLz0FdhpazjrUNmFne5gqYvKsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084704; c=relaxed/simple;
	bh=mdMW6L6vLM7AETD1AJOGuPexCgv94MM9Av8w35YdBjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+PUxDwKxHQtddyEyEWWMFdJpiNCvgC5UXSvCwv8zHr3U6JkLFtJibLVQooBb40fHpauhljiKVEeMdCuGaVS0yKe2/Ne8f9CvOxnaqpPru2hcSCiNdj0/niuoKw+uRdXovWEPjRLiL10dzmSeumzApFUmD48JuNg0zOXZWAmIaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o6znuUZS; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4905e190c71so71065885e9.3
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 12:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780084701; cv=none;
        d=google.com; s=arc-20240605;
        b=JBTPHQ51YT9lYWpy1c0tkiVHmbWdb9B0Uo1kh/88124c0eoSZt5mFMQsDhY4dNeJ20
         CQ2ydAcHJJRC4GPPokGiSDIETAOWBBRKWUETFkEZMK9La/XEiqD8Glznk0l5b+bc5dlr
         bF5gnn9v1ckDr+fA1tU81CNMJOpXgDIZrC+GmvtbVrxx9MdFNDBaFk7KBCtP3VbH5M9S
         nxNYtw5byXJ3NUeEb701OKHf8C1ysmmhVtn7hL1Z9K7XrYAxl2nF1mYdJJa1Q+Ee3r0p
         L+wUq81itP654Cic4Y1pNWH7W3NNbw/axvLyOvLtbP1bmSDZiM3kun7jfxhJBzDcIo0G
         8d0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LfwYj4DA5FPfcIbVqcNLhmYJgj92y6YUeOF+OaLYeaY=;
        fh=FdmaLbzBK4P4Ve9DiMGOFhDTEcGoZytMQOCw9tDsrQM=;
        b=YjACqLriKRZjMO3xKkDX6svSOfOlmPSjnYBnRqcfJBAIOe+Wi8Q2cinrrf3p9bWrJ9
         42rSps/M6cmKR6e2vC/34o+RyGExIE2s3X7ENouefJotskYwtSqSrMfqJKlzzmITYhSn
         LP/m4LUemhCQcOeuctz+RbhsVz767PTL1ZZXGB09z7VQkFUlUaBdtgfxVRJOhkqhL7cT
         Nnbd7nOuL+5XKFldpnr031RFRxWkhW5nTnNCCDjhHjlXnhNewjuAjCs8IngTlOJEhxaP
         C+GOVSXW1O80Sty4b5w/qSi6MZyNqx0cpuiHLaCKI+k6863G+t7cSGA0rYhPOOnavkbW
         RHAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780084701; x=1780689501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfwYj4DA5FPfcIbVqcNLhmYJgj92y6YUeOF+OaLYeaY=;
        b=o6znuUZSJv+kt+BcNYd9Nw+PTuUPcR7zEO0tMwYd12Sl7Kl50eTOnC43IMsC2CRlg4
         +HCgMyVptthi0NZ810a5B6GdVFPFpWWVrwyOam7Yx3SVTtCAC/VRmVSuuSkjVd/e69/+
         vEDrKIz8MTAVAer0ybZEl3WQv826E3pptznX9mRooSYzYZ9dhsro14kJywbpx/CEUGEZ
         GnZMfgaEXopiPxzdBFvO1HyNYVs1bR/Ll0QktgWr36wRgysD4GQK5fq3hTCWONxuIAJC
         6c7NtXCCZgbWjnZh26XXjTmKX9+bdRGZIi/5aFTY/2A6wddZ+MPKFdga4JoNUYxAL+mW
         xoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084701; x=1780689501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LfwYj4DA5FPfcIbVqcNLhmYJgj92y6YUeOF+OaLYeaY=;
        b=kGNI4qipw/qhkUSeq6fwbetUF0krugjEiqMobzAR8o9koUOl2i0OBcss5xKTJU9nwC
         GDltSnuBeebVMc1cj35lCvYK8j89hUj14gm8iltKFAC3HlfJkZbNLTx+lT2geCiulBdz
         OhpelPjEJXxY2+hPiTsV3BurlPlUtk0OIUUxVS9CMahBCF7wo7u0xp524zw+SpMTShYe
         CIvM0dl7vaqMjDwpSJkdsHhdTrqp4IFwOVb9jPVwFDvDr63krIC4vD2MZMLNwd9DwMMl
         dRlt/mWhHJr8xR4EldvZAKN914D2JLs5DvhBy1mf676KmdJ4diQB3Eh/WnhL91xrl9Bx
         EhDQ==
X-Forwarded-Encrypted: i=1; AFNElJ9elaXD18tQaUt5c11TQ0zg98KxqwY0FJTwpnF86fVBGLoil6sQglazbtOEb1P5235HkQr7zQlV@vger.kernel.org
X-Gm-Message-State: AOJu0YxzMgM1inJnhqV0Qj/wmt+4SoPkAA97BkQIRdSPRU1hwJzaBU/K
	k8K8VPs5sbQPwBNdsqWG+71UGETkSDk1ZLigNlruDIBVkG9fr0TB02cxhMiuOcAyopNA8g+/ixW
	s1+OcSpmlcQGdfkGua/yCk7oPkJh24Dk=
X-Gm-Gg: Acq92OGnb5kR0JTJ210DFdwdFzvApkozlQTftmN2FebKfR3VQbL8bTAFb+HOqLcH7eC
	rWwSyHvy++9zuCz/p75tItkjWMfDeGX8jz35NIP7J9nTO/1hTb0xmwgEaErfHqgbnsCK46HWfiu
	PRD8aqLVXVCZlDHAFyvtRWc/+B98fYXZJGJnM2BnfmDCvoolAZ9sibK/xf6mg+nJRGz4GAP7COa
	jk5RSSIj+z2d/IWrFlAE0hRkstW5EqrJRufKdvkPmIuH7pMuqEjpx30sd/6tAM9aIDe/BDrQ1xI
	mqnrOXmdxiYbGY1gwuzJv7hupC4l9jPrgxMdxqO/tbO4H35OMNv38Eqb5Xee
X-Received: by 2002:a05:600c:1d86:b0:48e:60a3:220a with SMTP id
 5b1f17b1804b1-490a28aa789mr19945345e9.0.1780084701135; Fri, 29 May 2026
 12:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526114601.67041-1-jiahao.kernel@gmail.com> <20260526114601.67041-3-jiahao.kernel@gmail.com>
In-Reply-To: <20260526114601.67041-3-jiahao.kernel@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 29 May 2026 12:58:09 -0700
X-Gm-Features: AVHnY4KgMD945lA_grdRhWAHXr8MpUc0KE7VWOqQOVSVohEoWbBZtrIU7fMWjKc
Message-ID: <CAKEwX=MQe_KFZe2vBXQYh0aa-x+E8AzNwmyjJGJk4tDoS9ML3A@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm/zswap: Implement proactive writeback
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, yosry@kernel.org, mkoutny@suse.com, 
	chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16460-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lixiang.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 65C0B608290
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 4:46=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> w=
rote:
>
> From: Hao Jia <jiahao1@lixiang.com>
>
> Zswap currently writes back pages to backing swap reactively, triggered
> either by the shrinker or when the pool reaches its size limit. There is
> no mechanism to control the amount of writeback for a specific memory
> cgroup. However, users may want to proactively write back zswap pages,
> e.g., to free up memory for other applications or to prepare for
> memory-intensive workloads.
>
> Introduce a "zswap_writeback_only" key to the memory.reclaim cgroup
> interface. When specified, this key bypasses standard memory reclaim
> and exclusively performs proactive zswap writeback up to the requested
> budget. If omitted, the default reclaim behavior remains unchanged.
>
> Example usage:
>   # Write back 100MB of pages from zswap to the backing swap
>   echo "100M zswap_writeback_only" > memory.reclaim

Hmmm, so this 100MB is the pre-compression size? i.e if this 100 MB
compresses to 25 MB, then you're only freeing 25 MB?

I'm ok-ish with this, but can you document it?

The rest seems solid to me, FWIW. I'll defer to Johannes and Yosry for
opinions on zswap-only proactive reclaim.

