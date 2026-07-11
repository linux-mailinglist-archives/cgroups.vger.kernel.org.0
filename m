Return-Path: <cgroups+bounces-17662-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xS13BpvaUWp3JgMAu9opvQ
	(envelope-from <cgroups+bounces-17662-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 11 Jul 2026 07:54:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EC174072B
	for <lists+cgroups@lfdr.de>; Sat, 11 Jul 2026 07:54:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=readmodwrite-com.20251104.gappssmtp.com header.s=20251104 header.b=dLtyv4E0;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17662-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17662-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB0AD30194B9
	for <lists+cgroups@lfdr.de>; Sat, 11 Jul 2026 05:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271D2306742;
	Sat, 11 Jul 2026 05:54:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F42E3033FC
	for <cgroups@vger.kernel.org>; Sat, 11 Jul 2026 05:54:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783749271; cv=none; b=sfoxE838Ot5xiTgye2lOzIgEHJApPB9TRhpjAkGCUDNDayhP3iuzgPZoZeXfeX0oaOJlGJtWlhNZg7TaZsuPaDmD9GVOpbQVtbJTGEy/2Cy1WQgt05QDuf6cO6bZreYmn29BJcdLeQDlv4+f7paCXKrw6rM+CzG4qcwq491eXPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783749271; c=relaxed/simple;
	bh=s8jLFIScodMQ29MEof5LclbjYvJlO2j6tbNbsN+hPN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdoQAaEWsZ8oDVnEzeOzsHexrfmUAbvNlNT0OaGlqgfmL/seTyh/aBZAC9kGVIQY+Di3gCpjPNbyI+HokjHsACV0T9YMF5C+ZS2FwcYgVbusuduAZbFsSxr6ZViRhPaOmIVZC5OqoQq+GJAo1DqdivpHRPk+mXBjs7/2FTWH9Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=dLtyv4E0; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso867197f8f.1
        for <cgroups@vger.kernel.org>; Fri, 10 Jul 2026 22:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1783749268; x=1784354068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s8jLFIScodMQ29MEof5LclbjYvJlO2j6tbNbsN+hPN8=;
        b=dLtyv4E0xctcWwWXqtndK1SrCB8Ft/7IgzU1pDkgC7pETdYQSn1WZMd/JA2WIEAHyr
         9tZrC4D+IXEnk0FGjPL0etK3ZtFd3UDqbpGDracN0gyGDlaejjVYleRsKnU9QvmrK35C
         j1rJYZeoj2JPRCE4PX9TUu7Ef7wMTunBwhSE1isd5gGxY0yePa68fotLyh6Jzvsti5B9
         T3iRqH3M1ojqJlQdcTH9a+szjBrHIWtHqVReebSoE1eouszLRjFgoForA/A+yQLvCyHb
         D/ZVLTEAdMeEyi/To+xIS0r4EaOySIXA75yZCO6kvgXfIFtUAO+jFSe5FAcViy2Vxr5K
         aDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783749268; x=1784354068;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s8jLFIScodMQ29MEof5LclbjYvJlO2j6tbNbsN+hPN8=;
        b=Iuk9RIzmTjsbyEU6hM+YeJvIIV52kv3TrOQUB5CAT6JUfuojkt/9M/zZBJmRxPMza9
         y+Yy9zZtGYKmVq5hRQTXENTafp/+lf/ldiuy5GB+WDTeqmQmHtVLZXtFj+rSSCXeZsYG
         GkuauQvhd5h2AbTaFXP8vGx476vu9rOLumOTpo3YHTZ2BV7//JHBNICwh39TwGXXc0Hb
         a6ph8GjEgDiCiRwOR60lSSSGGCIzs2sKnm2bGv1wKEmd5eoNWinmy1UT1MY+DeziDoFI
         KR4BichzhqNfqFHJFRt+5grwqSqJ8bXRa5DmTGQKA1NGuxw0xtZHlFKiYFi9WB/XUUo1
         +EHQ==
X-Forwarded-Encrypted: i=1; AHgh+RqHVcKetnzH49h6u8EtNVgiHlTItDZqvxbz+t7Bn3k3ZW3+aAIS93+gTVAR9bIyy2R1/huVvP4y@vger.kernel.org
X-Gm-Message-State: AOJu0YwmTz0b4Lfq7afB89WZR2rXlEpREt7skyZFdTc/3xRbjIYKsMJU
	+1HEK4YFOG/Ue+w7OtUEJSwtaAjWd5zPDXNkG799n8kjXnPjb/kn8/iTbsjlEpGsHmc=
X-Gm-Gg: AfdE7ckUGKgYG38jWZbFBZE0OswRapBvNsTYXKRiEfF2rbXKjHIFWhO9DZnyTefAQUg
	232tftNWLGokCk/ZIkbENkTO2DxURdvObWugHdN0mwA5otyuzj9AXdw/v2uOlv2FeIpyId9QMv7
	gxUqsirAwVpNvQJafL+Vaw+CE14eaeJjWW/1SW8ljBMaXwScdxfuF5Ahqz4C/eOvNGyED97BRD/
	tP1EmRG4oQYj/NMBsGW4TKjGtkOY0r8y/upqXW4zsRwmOLQrAmvNtNgcidCcO5wfO732T7zHi5d
	YEDix00RHbdy48MD1LpvKUHgTLxnPwHf2PIk31OM2S1ZIvf5cpFqqV0b1o8zlkvRvw98qOYhLiY
	mfqRsgoM/EGgEwkZIT2HD7vsV/I17L02jV61cN7UD+IDOZcY5NFuzAC/pK+YJqX3nOFI1UwpND0
	I=
X-Received: by 2002:a5d:5f42:0:b0:475:5454:49f2 with SMTP id ffacd0b85a97d-47f2dcbffd3mr1436432f8f.24.1783749267440;
        Fri, 10 Jul 2026 22:54:27 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:26dc::3df:54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f21328sm67191335f8f.32.2026.07.10.22.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 22:54:25 -0700 (PDT)
Date: Sat, 11 Jul 2026 06:54:25 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Suren Baghdasaryan <surenb@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Edward Adam Davis <eadavis@qq.com>, Chen Ridong <chenridong@huaweicloud.com>, 
	Matt Fleming <mfleming@cloudflare.com>, sched-ext@lists.linux.dev, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH cgroup/for-7.2-fixes] cgroup: Create the psimon kthread
 outside of cgroup_mutex
Message-ID: <alHaU4MhWzq9kA1i@matt-Precision-5490>
References: <20260710100441.2653477-1-matt@readmodwrite.com>
 <20260710134945-psimon-fix-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710134945-psimon-fix-tj@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[readmodwrite-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:void@manifault.com,m:arighi@nvidia.com,m:changwoo@igalia.com,m:hannes@cmpxchg.org,m:surenb@google.com,m:peterz@infradead.org,m:eadavis@qq.com,m:chenridong@huaweicloud.com,m:mfleming@cloudflare.com,m:sched-ext@lists.linux.dev,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kernel-team@cloudflare.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[readmodwrite.com];
	FORGED_SENDER(0.00)[matt@readmodwrite.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-17662-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[manifault.com,nvidia.com,igalia.com,cmpxchg.org,google.com,infradead.org,qq.com,huaweicloud.com,cloudflare.com,lists.linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matt@readmodwrite.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[readmodwrite-com.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86EC174072B

On Fri, Jul 10, 2026 at 01:49:45PM -1000, Tejun Heo wrote:
> Matt, your reordering trades one deadlock for another: CLONE_INTO_CGROUP
> forks grab cgroup_mutex inside the scx_fork_rwsem read section, so an
> enable racing such a clone deadlocks the other way around. The fork has to
> move out of the locked sections instead. Can you verify this fixes the
> deadlock in your setup?

Thanks for fixing this. I'll test this out ASAP and report back.

