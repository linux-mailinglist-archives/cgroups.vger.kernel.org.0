Return-Path: <cgroups+bounces-14224-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uExPM4DZnWk0SQQAu9opvQ
	(envelope-from <cgroups+bounces-14224-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 18:01:52 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7135718A3CD
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 18:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B9A031DC7F6
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 16:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1488E3A962B;
	Tue, 24 Feb 2026 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Z2zmejZV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966AA3A9015
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952098; cv=none; b=SiBZ9ZcDBmbRaBi3ocrDwhcUuEymFmRku8uXIrPXhUkLXGHW1L5f8YZZglmHqKffD/M1a7r0H3uhorpImnUxqqYb5/LLb6fuqeYt2hCp7tey1ZtXK73ijswLtAAV6iN7KgIQWlByJK4ih/Us3appAHlsn2axhKlrBgxWVaGkMYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952098; c=relaxed/simple;
	bh=jdCxOTtyEPr/iR2B4h4Aq7P1P0AhdAHaD1MtdqqOD6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dI6b0sEKqegYcRfHmpItLe0h5P95tXFzJMwoNBkyyat2IUV2k69/QBp0WEzAhqvg0zUXSyTElALLDn/uGFfiNsJ3EZpxebk+VYETfA0ew53tQvQ+w13QBvQyIIs1SC6cP6L3SKtFPQrtOBNlm/xOWmet8/rd5SbjJlS6c88n26s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Z2zmejZV; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-896fcfc591eso53986376d6.2
        for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 08:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771952096; x=1772556896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/u4GoWFznFuQrqLlGOUj7jRuDM2CBLv4iVo/JzLKZig=;
        b=Z2zmejZVquI1y0nNwLqNgdh++8hSr+zpDa2yV7e0wOzQgDnLWmrhwFjX3Nz0nCaNJr
         8eBG5VQI7nts0IIFMCVb/AGg7lhckLxHal2BBu41sPjWLsUn9PQo2mHQluPTkW87sgOA
         NAkghOy7LRthIUbPKhMKbI+0rttrlsTGnTevisRUYEmI+E7Ue+pcyw1U8RnvQF+f1eQa
         5GgaXeUYhX25bEpZxL3JYLOmmIvDbHNr0v+qNJuZqXKevCPK1LFvWAihoPf68qZfXDxN
         js+YwTbh/Jir44XqV7VH2Ue8EGBN8Gqx3O/80yRMxO9BZNvkIrS2XbY6gMdDe+Kus5t3
         d8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771952096; x=1772556896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u4GoWFznFuQrqLlGOUj7jRuDM2CBLv4iVo/JzLKZig=;
        b=P7MoL+XWMFy8QVVlmOsljvayycepxGqK9QifC/BNQ5WeNIc7a5W3DuGW+JzuXB6k6G
         5fasZ3HNVA5JshqtBUwyfzsNZfHbM/Sm2Uw45q1lbWp6x0ZPthPDTnBaedOF2+GrpEFI
         WmZXwOrqQuXPNDt59z+UxQ5l96zmqYFSq8BNrOx61PLblF7BxXl9ejlq9X01Od8xRCtU
         993w4sSysvG9iQw8axKPfRt5YeXF/GBuTRkS0HwAfBkmXOR2dxQMoc2foFI74qd6plp/
         lDN9fznTeOG3em8kloP+OiMoAvvgL0kzx4iivOf7NoErQtE61CQD7gwzpTDoWQYVp1sm
         2jeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe0+w+VsV5xaq80Ywr7R5aiXEso3Ivcw9eZwZtVy8kJikz6s90+3gnMpUrrsYwz6M4UiOC3KA+@vger.kernel.org
X-Gm-Message-State: AOJu0YyQKOPEzyrUd6Zq0QZrm8t7b+tCXZXCOLpJVPR4Gn6RVlg3NFJd
	xqxX6RcCZSPb3UFrr9Vz538nJ4gVoZJ9xtAT+ALn2zqFrgM9TFRBf+tDupW3WaJUEXE=
X-Gm-Gg: ATEYQzwZcx0lE3YxjwT9bV+lAGGlEB2qHnrK869CIwkMgmsn12gjcFU/FruR2xzrFaV
	bMlnik5xqkQ7ctQE/7Py9k+4INfAy0Pcm96dRqAbni7DTHiO1fn26PtbzEsAUfHifXux9NRXd6G
	/5IxJmbsUuiKe0+YTFI/IH6HJh3CyJuea7HGvb8lJin06kGTmLvll9KsEpcQzo0JtVjNKFAoDJt
	xvJiGHnRBw1IV+Gx0+lFY3fF6q5p5Tgryu62HI4SOAVuAAgjyBT0pkqeFfe9FSh9evJLZEZ4cmX
	UOQb0uvXf4qsPtgDpIyyECW5UBRwiqbu31/scB2pQF/4M9F159sgQReJsIgUBgZDrzz1Dpw/gV6
	iaKx93W8Cqj+wnB3tQQBKDI6pSfB+YuTHRQiMRaJ+vixrvaj7FXlGVvtlpUkg7OqZ+fT/oxG9h7
	abYaehIMWZVboaNqNJPsiC1LdvXrXYmw/bjifFz42waaTcdBfgpFRVll6jdkRsH5fqrzL4idS77
	ZZWmYzjpg==
X-Received: by 2002:a05:6214:1bcc:b0:893:4efa:e8aa with SMTP id 6a1803df08f44-89979e317cbmr188639836d6.9.1771952096264;
        Tue, 24 Feb 2026 08:54:56 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0ec694sm1029766685a.29.2026.02.24.08.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:54:55 -0800 (PST)
Date: Tue, 24 Feb 2026 11:54:52 -0500
From: Gregory Price <gourry@gourry.net>
To: Alistair Popple <apopple@nvidia.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aZ3X3Jni0HZXZMVl@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <fzy6f6dpv3oq3ksr2mkst7pz3daeb3buhuvdvcw4633pcl7h6u@mxjgiwpg5acv>
 <aZ3BEn_73Rk8Fn7L@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ3BEn_73Rk8Fn7L@gourry-fedora-PF4VCD3F>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14224-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[gourry.net:query timed out];
	DKIM_TRACE(0.00)[gourry.net:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[73];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7135718A3CD
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 10:17:38AM -0500, Gregory Price wrote:
>    - Changing validations on node states
>      - mempolicy checks N_MEMORY membership, so you have to hack
>        N_MEMORY onto ZONE_DEVICE
>        (or teach it about a new node state... N_MEMORY_PRIVATE)
> 

This gave me something to chew on

I think this can be done without introducing N_MEMORY_PRIVATE and just
checking:   NODE_DATA(target_nid)->private

meaning these nodes can just be N_MEMORY with the same isolations.

I'll look at this a bit more.

~Gregory

