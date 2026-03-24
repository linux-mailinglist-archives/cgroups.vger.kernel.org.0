Return-Path: <cgroups+bounces-15025-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Dl9CimtwmkyggQAu9opvQ
	(envelope-from <cgroups+bounces-15025-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 16:26:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A49317FA9
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 16:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76CD7304B3A5
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 15:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B3240245C;
	Tue, 24 Mar 2026 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DmqjbMUP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F383D5246
	for <cgroups@vger.kernel.org>; Tue, 24 Mar 2026 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365812; cv=none; b=YOy53mDBIXLhh07x/065HFx3JGAvCzf3uSKgJN5B/JWAppSlewJFbRiQQXJQ0q/s+b88Vn/a3z/6XLNIkrFvUeIpAyuLGQUSi3Tx0/TsPsvTvQEppk7BjuNy3s33mN7l+c7XDXZQyxDu2SWbJPD5zP4MP7fN+yyk6tmfoXQ5Llk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365812; c=relaxed/simple;
	bh=eBIb1ZNnQtgJPCgnufRRyjX7zGSQdC1Es+T2piwApMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxdywSAYlS6AxiqSkzIKUKHG5HvDgiSkq3MGEo0LCFqDkZ7+kj0G/uQxpJzgf5vWM5w+4fIG0toNv2LC7p9y8E786WlPq5NLLxwqyLjlBwNLxxLVhkCaRs/rtZzIr3up4at+34umQfvwLJvCf9cpdA0CyS6qORw4whqTXAtHiSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DmqjbMUP; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89c52ef3c2fso12689206d6.0
        for <cgroups@vger.kernel.org>; Tue, 24 Mar 2026 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774365810; x=1774970610; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dN9bTdcC5or2P8tjA2XnE4l+JSY6/+Dfgf14OK19Eqo=;
        b=DmqjbMUPHBKQaHQAIHGZlBLsswjFXHTYze99zHsAlCvVk0cWNQgPhW7Vl/m2W9/N6a
         iOVQZSW4sa0h1ZwZFA4d6RjskDb2EUN9tJA9E+DIJMaTEzMNpEi4mfqRve4Erq6MB+8Y
         ZFX0JriZcR7rfVl9LcQMLZb2kkJ8a9FjTXqGlhK4xwn5MwA9LxDs5wL2eQ+3Otp6pwBW
         AKnPjgvoN3IW/yjdKQbASJnHEQnTdV8MY9taR+LGuUUNtvM1OruKktJi4WpNyKSkVXE4
         tz3z6ieiInvLZXBv1F70cSHD/gJ79EsFT3tbERIKgTurq9VZjqHAcHwrOp01Km54i6VG
         skQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774365810; x=1774970610;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dN9bTdcC5or2P8tjA2XnE4l+JSY6/+Dfgf14OK19Eqo=;
        b=f2R49tXCud07x25Lw6i+SNqi3uD7JZ4kvZFbhcXuN0IBY8vlWRdyenB6hHEQ53w8JV
         8N4PNmbm2wKaIPUivhwLC/n6fT9N8R4uqPMGdSGefIyomFSwP/grRv38VOm3Gn04tKpk
         UCt5NtS+Qfw3uMcqAoXe2iZ4APTlz6YGciUHsIPnYhTWyUX+Tjeo299nvEugYJZh2l8W
         PmydSaIiq2pZYti+92QzDzEA1gm/Gzb7RFVgjAWtHNuhzkpvquuc5QDaNmU4PEXPAYax
         5eKOkQ442ZiX0k9aOS23nofOytYfJPxtp89gcUBs9e0WxBpIKrFkUPOYMJ8wqlo0tc8M
         +gfA==
X-Forwarded-Encrypted: i=1; AJvYcCUrzXQ35o5A8YnyTQk9npzZ0DE/5HDZHvab3IvufjifQn2A8KhEzzx88xheLHn09WeUkPEN7FmN@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6vDJYY7NqAC1bUPFCsJ/IbVFyO5opgYqgN9KAZ2Pfk3+yl1em
	ltkNZTFfiyIwCbLQ/UCztD3aQkP5n6Wiey+lwGTD9qbIpDVNTm9XJotZea8Egi8jmsY=
X-Gm-Gg: ATEYQzzynpLRlHVsjTXk/pupszdUlS4KWH4teHVgHm5TE45QJmpkN2wvEmS6qbB+h5N
	4Y33wkJmj4zHVaq7CPC8tWcWCu2GqAsM/DSaZMSHksANaO7M0PsAn48/wTc3YTVgxWzbkY3D4HF
	iohxJykxy3Qew+eclVpGY8V96QmlLywQoTtBZFkvNJjnYHHTY5kiipv6lVB1VF0cvUYXkpVz5mf
	pt94ZROxmwpU2OK7eLKwPFq4hofonAgZ3wxwh+3qN4IqYyHN5d7Yu83Hj/oVpC5IaPFQb5dGcoD
	XaK1o2dZ+3r1o/rcY2rMkCeJjTFRv8nSRNgO3F3xMWlKg75pzHx/rKJm4QpceBslcssDF6VGOym
	nE0Etd+yCEngEuneQriZNS8+Y9QB8AIV4eEn16oDlsBilV82gCrNJy785kCDFk2x1UwAwT8AYTI
	ZLWflxeQq8jTSGgxlCGw==
X-Received: by 2002:a05:6214:3306:b0:899:f929:d85b with SMTP id 6a1803df08f44-89cc4b1be87mr159996d6.61.1774365809892;
        Tue, 24 Mar 2026 08:23:29 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::de62])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c85335745sm117576556d6.32.2026.03.24.08.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 08:23:29 -0700 (PDT)
Date: Tue, 24 Mar 2026 10:23:27 -0500
From: Gregory Price <gourry@gourry.net>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH 6/6] mm/memcontrol: Make memory.high tier-aware
Message-ID: <acKsb06lnywch8DV@gourry-fedora-PF4VCD3F>
References: <20260223223830.586018-1-joshua.hahnjy@gmail.com>
 <20260223223830.586018-7-joshua.hahnjy@gmail.com>
 <90749965-ebc8-43b2-92e3-baec5f6e3de0@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90749965-ebc8-43b2-92e3-baec5f6e3de0@linux.ibm.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15025-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,oracle.com,cmpxchg.org,suse.com,linux.dev,bytedance.com,google.com,kvack.org,vger.kernel.org,meta.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gourry.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71A49317FA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 04:21:06PM +0530, Donet Tom wrote:
> 
> IIUC The intent of this patch is to partition cgroup memory such that
> 0 → toptier_high is backed by higher-tier memory, and
> toptier_high → max is backed by lower-tier memory.
> 
> Based on this:
> 
> 1.If top-tier usage exceeds toptier_high, pages should be
>   demoted to the lower tier.
> 
> 2. If lower-tier usage exceeds (max - toptier_high), pages
>   should be swapped out.
> 

This is not accurate and an incorrect heuristic.

Transiently, lower-tier usage may exceed (max - toptier_high) for any
number of reasons which should not be used as signal for pushing swap.

driving swap usage is a function of (usage > memory.high) without regard
for toptier / lowtier.

> 3. If total memory usage exceeds max, demotion should be
>   avoided and reclaim should directly swap out pages.
> 

This is also incorrect, as it would drive agingin inversions.
Demotion is a natural extension of the LRU infrastructure:

toptier active -> toptier inactive -> lowtier inactive -> swap

if you do (toptier inactive -> swap) you have inverted the LRU.

As far as I know, from testing, we retain all the existing behavior - we
are just managing a limited resource (top tier memory) to manage the
noisy-neighbor issue.  So...


> Should we also handle cases (2) and (3) in this patch?

No, I don't think we should

~Gregory


