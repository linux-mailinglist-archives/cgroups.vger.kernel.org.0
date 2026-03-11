Return-Path: <cgroups+bounces-14768-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBMvDSqvsWmzEQAAu9opvQ
	(envelope-from <cgroups+bounces-14768-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 19:06:34 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4963268699
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 19:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F256306D8E4
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A9B3E6DD3;
	Wed, 11 Mar 2026 18:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="QsFV9I+l"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF7FA59
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252386; cv=none; b=LsAHdZqWQrR3Y+HxkVqC44Kt/ZJhNU8SbPXOSexKrgeIl7oGaOoRhwYTnWvnvh8DeSQFs7astgSf9oW4graGdoD0I19FuhtvAQI1gbBGashnO6jzw+s4jBHMGxUH2PhMa59DGr8fBK2U3l7pZZSwuGt7oywIJNinKAvcWr59A4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252386; c=relaxed/simple;
	bh=it9qpp+UfqJRbKkDfvBHAN3iPpbPBunUvUAjiJOtfYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iW6xM/zoNqGgnO48m1hlWoZO1VEaSM8WC5Ve5Gu4l9jFfD1NPvWWZhJ2kl4X4UvIXBA3eEjPBLmjSXpgo4A6kPpinn2bAYW5bsIQrBrIWDpXmMZytD/bj5mK19/Pye7FTeMq+wuc6KdTVkTxgoGxbrEf2my354LWsDMHIgW9No4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=QsFV9I+l; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb40149037so11568285a.2
        for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 11:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1773252383; x=1773857183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bczgafP3myIIT3/uXjN5TcydziqRd7nkpIhTtM1x3Qc=;
        b=QsFV9I+lM2IckE9U1C7anbl0Fvm/SPTHhUIleAg66xffG16wPUiGM6+MQfvtl5G7dy
         hLOLcN2w/3w3+m5BvoLSyX4w1OtG+y1KVMWrAdQfJtTgRGXF4PNGg3sfvq27Fd2bN3fA
         kOyiig7qO+x/ihJafwHZYJyhhlx2nA/sgBRSFLmdAGS2joHHkaDJju2OSHKAxmWgO8RQ
         Ow215IlEBhOSFPY1JkEiUE8iUlfz6dSt6ULoNi3zPDTtvSEgEuINvPJTW9h9+qIEN01e
         tQ2c2FaPqYubDFNgsXhqDsaOQ4GHFDJdEfyUkBmxW4+gUZj2oqGF7saUfllWStUSG14P
         8Izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773252383; x=1773857183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bczgafP3myIIT3/uXjN5TcydziqRd7nkpIhTtM1x3Qc=;
        b=Xq9LCZCWgEnvL6xMvtXZAyhunmOvPkfuQ8cIwwpOuBV14Q7FB5ISkhcHLXkcy61kOV
         bpwHFlelOOlBrxBoOTLogRFs4GpleWNRlQtyI/UTWoRqlGEKCZ734/ao0+wDsxJc3Vk+
         Kdh+WaQ1kNVQuTJbxsv+MHC/U0rppxzpFueMT7FlZ6U4e8iOr1sXsGqz9hMn6DGappkC
         47toZ/q5HkD5i2D7UB8puv/mYxyiDOuzH8QIXtPYGMqX7yG76A4qKch5RZsCaV9uT0UL
         H32H2i6K0jllXuSzmliSy/6gkXbDPBWN09has26pFT1/3kWQkbOhePCBs7osbqGMjVbO
         RmHw==
X-Forwarded-Encrypted: i=1; AJvYcCVmSdq1W6REBCij61zZtlOblFZmlD3BIIUMypuL9QGLIjvh0sXKsP3+27q1wOKtjsmguoEHFpKd@vger.kernel.org
X-Gm-Message-State: AOJu0YzGfeIWbjpjuDyfkKq+w2pbkA8lb/fvdbqC/R/TX9TsZXL9P9Cn
	BNRXYEKgh3rn5bZdmw4MJwQN9NWYKz+VHfP/tR1DwNNxl3JpZSMv4aqDUurO89FeDMo=
X-Gm-Gg: ATEYQzyPGl0v6ZCzk7ot4LAwZhYcWLYrgjGnNAZHUcpvn01BdPJlmdei3+4DxHkKm/v
	LZi+3fIT2Ni67wWadxjmQk2UgFZBFwyAxgExdE/RNDIZmKMKQn2QI8a6/3qtVVL69GizmrOUWNs
	LnKNLJ9Zn2trQd8roBrxDkkjfyT+opX5Z3TC/tQAPhS0KKMeVpE1Iq+mgj84or8Nbh7Sm3Rgnoa
	bZD/JbejW0HQQc5sIzD/g/etbdxtIiaaD9ECbDnvSpOR70BHLm6zOHToSqyCgQKco+xCHjpCq54
	OhTqVLfVicVxyDVTszw2TFwiDwFfZ6YCo7BI0QgXrJY3Bo0U4JxU7gKCcrx6mXAIahUfXUTCJzx
	tQcA1w31GMDoRGLglC5EjuiXOS22bQ6skpj0WTOJG3+qj1ZAOM0kyqc7OppKwAQWGTL7kYkvc6G
	xedpM9Zu9VNQipderIj3N9Lg==
X-Received: by 2002:a05:620a:4053:b0:8c7:1118:c514 with SMTP id af79cd13be357-8cda19b1a5bmr446088985a.17.1773252383193;
        Wed, 11 Mar 2026 11:06:23 -0700 (PDT)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21540f5sm172182185a.45.2026.03.11.11.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 11:06:22 -0700 (PDT)
Date: Wed, 11 Mar 2026 14:06:18 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
Cc: Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
	akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
	apopple@nvidia.com, axelrasmussen@google.com, byungchul@sk.com,
	cgroups@vger.kernel.org, david@kernel.org, eperezma@redhat.com,
	gourry@gourry.net, jasowang@redhat.com, joshua.hahnjy@gmail.com,
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
	rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
	rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	surenb@google.com, virtualization@lists.linux.dev,
	weixugc@google.com, xuanzhuo@linux.alibaba.com,
	ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
	kernel-team@meta.com
Subject: Re: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
Message-ID: <abGvGjqke_3gYe6I@cmpxchg.org>
References: <20260308192438.1363382-1-usama.arif@linux.dev>
 <c64681a1-2069-421c-9e62-bb63e4ce261a@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c64681a1-2069-421c-9e62-bb63e4ce261a@linux.dev>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14768-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,kvack.org,linux-foundation.org,suse.com,suse.cz,nvidia.com,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,gmail.com,oracle.com,intel.com,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cmpxchg.org:dkim,cmpxchg.org:mid]
X-Rspamd-Queue-Id: A4963268699
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 08, 2026 at 08:30:47PM -0700, JP Kobryn (Meta) wrote:
> On 3/8/26 12:24 PM, Usama Arif wrote:
> > On Fri,  6 Mar 2026 20:55:20 -0800 "JP Kobryn (Meta)" <jp.kobryn@linux.dev> wrote:
> [...]
> >> +static void mpol_count_numa_alloc(struct mempolicy *pol, int intended_nid,
> >> +				  struct page *page, unsigned int order)
> >> +{
> >> +	int actual_nid = page_to_nid(page);
> >> +	long nr_pages = 1L << order;
> >> +	enum node_stat_item hit_idx;
> >> +	struct mem_cgroup *memcg;
> >> +	struct lruvec *lruvec;
> >> +	bool is_hit;
> >> +
> >> +	if (!root_mem_cgroup || mem_cgroup_disabled())
> >> +		return;
> > 
> > Hello JP!
> > 
> > The stats are exposed via /proc/vmstat and are guarded by CONFIG_NUMA, not
> > CONFIG_MEMCG. Early returning overhere would make it inaccuate. Does
> > it make sense to use mod_node_page_state if memcg is not available,
> > so that these global counters work regardless of cgroup configuration.
> >
> 
> Good call. I can instead do:
> 
> if (!mem_cgroup_disabled() && root_mem_cgroup) {
> 	struct mem_cgroup *memcg;
> 	struct lruvec *lruvec;
> 	/* use lruvec for updating stats */
> } else {
> 	/* use node for updating stats */
> }
> 
> This should also take care of the bot warning on mem_cgroup_from_task()
> not being available.

mem_cgroup_lruvec() and mod_lruvec_state() already do the right thing
for !CONFIG_MEMCG. Add a dummy for mem_cgroup_from_task() and you can
do a single, shared sequence for both configs.

