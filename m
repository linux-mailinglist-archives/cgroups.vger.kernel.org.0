Return-Path: <cgroups+bounces-13970-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELsWFCuHk2mr6AEAu9opvQ
	(envelope-from <cgroups+bounces-13970-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 16 Feb 2026 22:07:55 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A68FC147A36
	for <lists+cgroups@lfdr.de>; Mon, 16 Feb 2026 22:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AF33301ECE9
	for <lists+cgroups@lfdr.de>; Mon, 16 Feb 2026 21:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD1E2EE607;
	Mon, 16 Feb 2026 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fyUVW/k3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD181279DCD
	for <cgroups@vger.kernel.org>; Mon, 16 Feb 2026 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771276070; cv=none; b=oUnQuDWGLbnZVbJsjZECAcnM/L+q9ieklQNi78pSK9Knni5Q2dFxqPMURwGfQ2d84VI0WkerKLPhDcusAFY62ZjRLyWWWM1a3CUQpyxq57PvR85mJINSOCATxegYqA4Zgu5i7gDHFFX03Gy/5rWUryx+/0cggrKHkCd/z3uv0YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771276070; c=relaxed/simple;
	bh=ahY9nzIrmb3VN2PNtTKd4XYo5vjVSwt3GAvd5/xCOrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXo4k8hGdySiTafCtVPUmOqK8OsalR86jd0StTAVqBT7js6jmpGBNNz4ivSlkb2yrsmiWAd3wWBsx5jfYgPGvCi41iZcFdVaosa4A7aWTeCWq9O8Vu9+Z6vcXDxIalky4GRp7zQcn4MTrZQdPa/IthMzxI3DjNLFAcON6Udmfyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fyUVW/k3; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48371119eacso32985115e9.2
        for <cgroups@vger.kernel.org>; Mon, 16 Feb 2026 13:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771276067; x=1771880867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpRBCfCaKwzFeCSlkRPtiCqwRuCq3qQsbgDvpARfGfQ=;
        b=fyUVW/k3wD+KSJdN1setl/p2qnyMMQ7xCe2vceXlSSP52n4SJttsq3jq6lQ8alW40D
         UvmjdePyb0tiCljckqV2BCJLu6nAQddgeBdhLAHrI2G4nbPLAl+AJbFjvX4F4ntydn8t
         PgwycV8vqP+vjZHB9O2S23w4bgpV8n/K0TsA3doCVKbqOPdHjOjmLPRL8DAEMVZaUlpV
         +lfOw169MsN4x7T0LFLRuWU27B4jpCFz+njbcX5jH89AAbB7MW4Jj2QABA2r2nr4cmBH
         NyasSNJ/3fqHk5qA6zzrUjmGLtOCLt0xIHwugP74QzyokNrdIySO5xxcISO5vm6g4z2f
         bLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771276067; x=1771880867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpRBCfCaKwzFeCSlkRPtiCqwRuCq3qQsbgDvpARfGfQ=;
        b=I++AR1g4EZPUE0qY9YxkOfSisC18+WOsyK66+cNNBtKU/DgxGNd6iXKbqpJItWnphn
         djP9RSxxdrueb2TvroENPDD4TtstWQ5lPW9ONbft/BU8kbHeynb06S0uerX1kF+KW4GW
         MLd1wcoH3Y8Z6LyaAAZmsvhAWbEL6aijIdU9c6QVwN/ngZ6i8PWxSiHTY3yIheFDEZEE
         F6w4AYbgYAF2lb74LIZwQ/bkLWCOY9TVmMA8zyONiwP1bLGV7amKA9DdAbj9gguVET6p
         bbVGn+kMCJ2oA3/LUGGFOz7E2IWsr8RHE33b1O0cP+nJOf4kuaRw0MtSniwFjmm8NL67
         3uHA==
X-Forwarded-Encrypted: i=1; AJvYcCWDauMULo/Rzmmqj9rve2hZ7aoh1/nNoFeM+EXwI5OoaVNttX90ECm8nSOCm/tZR2bMAs9tqpIc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4+CJ7Ndjey0xxECaselG+JzX92ehg8HWM3eg8o2/+ly+rdBLm
	rFII9v9TKQxv/ZuaQdYKO3ssAXCzn/AyWLgpUlPRoUhaYbmobJZnigEETlGR+uulab8=
X-Gm-Gg: AZuq6aJ9V0Q6aMkBnrRkG4MlO1GmBdwXzX80nocIAXJe76juHLVz+kG63AwOqDuvXzU
	ZFB1GURrhMpSDxdN+1Df/VdEuCyVFTGu31WMBaA8ddjAfBg2WngdrmcurvrVq1zanuqO8doLimI
	AXoN1ksw/DpeRXHrbFjS3q0B+MD342iRhxLcb3QdwNw7549zXh1WK0+e1SZrnDq+ZUiQYhffdhz
	iZaSjitPveUQJnA/6jJHBRyuOFmsnxH9a7Ez1crGZB+FROPYHdE3z+oNXcjmk6O2m8PyEAiDtEZ
	Gky6ZXymhxuFb3Me4bmOxounvIkier1MUpGBs/cldVKof1A79qPmth/RxX9qHXQR98KMd23O3pL
	9CRX1rQuhTo6zwNVN/Z9MMDyV08P6bC9Mh37mmqW3EGh6mdOycZmMlMeoKDnEfEeoCAdiIi06cn
	yBI2ZltATm51XPw7d5dZFBPmazPowprx5JFlB+
X-Received: by 2002:a05:600c:19cc:b0:47e:e2ec:995b with SMTP id 5b1f17b1804b1-48373a1271emr193576735e9.9.1771276067044;
        Mon, 16 Feb 2026 13:07:47 -0800 (PST)
Received: from localhost (109-81-87-131.rct.o2.cz. [109.81.87.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5d77b3sm519573895e9.2.2026.02.16.13.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 13:07:46 -0800 (PST)
Date: Mon, 16 Feb 2026 22:07:45 +0100
From: Michal Hocko <mhocko@suse.com>
To: "JP Kobryn (Meta)" <inwardvessel@gmail.com>
Cc: linux-mm@kvack.org, apopple@nvidia.com, akpm@linux-foundation.org,
	axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
	david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
	jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
	rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
	rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	surenb@google.com, virtualization@lists.linux.dev, vbabka@suse.cz,
	weixugc@google.com, xuanzhuo@linux.alibaba.com,
	ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
	kernel-team@meta.com
Subject: Re: [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy
Message-ID: <aZOHIQj3pJ-9dW_0@tiehlicka>
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-2-inwardvessel@gmail.com>
 <aY2BcIHIARSwwQpo@tiehlicka>
 <eca7a8f9-173d-4cb0-93b3-df082b8d0c08@gmail.com>
 <aZLUm95Y-dKkdBWI@tiehlicka>
 <3fe7c5dd-b184-4421-a21c-bafce6aa7b09@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fe7c5dd-b184-4421-a21c-bafce6aa7b09@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13970-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kvack.org,nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,suse.cz,linux.alibaba.com,meta.com];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: A68FC147A36
X-Rspamd-Action: no action

On Mon 16-02-26 09:50:26, JP Kobryn (Meta) wrote:
> On 2/16/26 12:26 AM, Michal Hocko wrote:
> > On Thu 12-02-26 13:22:56, JP Kobryn wrote:
> > > On 2/11/26 11:29 PM, Michal Hocko wrote:
> > > > On Wed 11-02-26 20:51:08, JP Kobryn wrote:
> > > > > It would be useful to see a breakdown of allocations to understand which
> > > > > NUMA policies are driving them. For example, when investigating memory
> > > > > pressure, having policy-specific counts could show that allocations were
> > > > > bound to the affected node (via MPOL_BIND).
> > > > > 
> > > > > Add per-policy page allocation counters as new node stat items. These
> > > > > counters can provide correlation between a mempolicy and pressure on a
> > > > > given node.
> > > > 
> > > > Could you be more specific how exactly do you plan to use those
> > > > counters?
> > > 
> > > Yes. Patch 2 allows us to find which nodes are undergoing reclaim. Once
> > > we identify the affected node(s), the new mpol counters (this patch)
> > > allow us correlate the pressure to the mempolicy driving it.
> > 
> > I would appreciate somehow more specificity. You are adding counters
> > that are not really easy to drop once they are in. Sure we have
> > precedence of dropping some counters in the past so this is not as hard
> > as usual userspace APIs but still...
> > 
> > How exactly do you tolerate mempolicy allocations to specific nodes?
> > While MPOL_MBIND is quite straightforward others are less so.
> 
> The design does account for this regardless of the policy. In the call
> to __mod_node_page_state(), I'm using page_pgdat(page) so the stat is
> attributed to the node where the page actually landed.

That much is clear[*]. The consumer side of things is not really clear to
me. How do you know which policy or part of the nodemask of that policy
is the source of the memory pressure on a particular node? In other
words how much is the data actually useful except for a single node
mempolicy (i.e. MBIND).

[*] btw. I believe you misaccount MPOL_LOCAL because you attribute the
target node even when the allocation is from a remote node from the
"local" POV.
-- 
Michal Hocko
SUSE Labs

