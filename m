Return-Path: <cgroups+bounces-320-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A74F7E7C22
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 13:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5B01C20C4F
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 12:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6291818E3C;
	Fri, 10 Nov 2023 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cIHSZ08P"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9689E18B14;
	Fri, 10 Nov 2023 12:24:24 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558F83367D;
	Fri, 10 Nov 2023 04:24:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0A0BC21986;
	Fri, 10 Nov 2023 12:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1699619062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TEMlJTypraY6MioDn/TZVL4tcm3Oo4k57aQCpucll0g=;
	b=cIHSZ08PXwgBV4D2RmTzbFq2GyGr5+BNUU+GuQ9Fp/jFC75c8eID5PAMgs6kguz0DrNQYI
	SbSO3khkf4I2EI3HmokhHYfmtDkbYdzfpJdJTAwA8MBEhid3yd9fqH5Xf6AAKlnTp5FY1j
	O7SiT6Gk3d39XEj9inJvHDcoTJPrWL0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9BD2138FC;
	Fri, 10 Nov 2023 12:24:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 01Y1MvUgTmXhGwAAMHmgww
	(envelope-from <mhocko@suse.com>); Fri, 10 Nov 2023 12:24:21 +0000
Date: Fri, 10 Nov 2023 13:24:21 +0100
From: Michal Hocko <mhocko@suse.com>
To: Huan Yang <link@vivo.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Xu <peterx@redhat.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Liu Shixin <liushixin2@huawei.com>, Hugh Dickins <hughd@google.com>,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	opensource.kernel@vivo.com
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
Message-ID: <ZU4g9XZvi9mRQD27@tiehlicka>
References: <87msvniplj.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1e699ff2-0841-490b-a8e7-bb87170d5604@vivo.com>
 <ZUytB5lSwxeKkBW8@tiehlicka>
 <6b539e16-c835-49ff-9fae-a65960567657@vivo.com>
 <ZUy2-vrqDq7URzb6@tiehlicka>
 <e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com>
 <ZUzTVgK_i05uiHiB@tiehlicka>
 <e07c977f-8c73-4772-b069-527c6ac0ae4f@vivo.com>
 <ZUziy-6QPdTIDJlm@tiehlicka>
 <f46de374-82a2-467c-8d32-a15b518bff17@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f46de374-82a2-467c-8d32-a15b518bff17@vivo.com>

On Fri 10-11-23 11:48:49, Huan Yang wrote:
[...]
> Also, When the application enters the foreground, the startup speed
> may be slower. Also trace show that here are a lot of block I/O.
> (usually 1000+ IO count and 200+ms IO Time) We usually observe very
> little block I/O caused by zram refault.(read: 1698.39MB/s, write:
> 995.109MB/s), usually, it is faster than random disk reads.(read:
> 48.1907MB/s write: 49.1654MB/s). This test by zram-perf and I change a
> little to test UFS.
> 
> Therefore, if the proactive reclamation encounters many file pages,
> the application may become slow when it is opened.

OK, this is an interesting information. From the above it seems that
storage based IO refaults are order of magnitude more expensive than
swap (zram in this case). That means that the memory reclaim should 
_in general_ prefer anonymous memory reclaim over refaulted page cache,
right? Or is there any reason why "frozen" applications are any
different in this case?

Our traditional interface to control the anon vs. file balance has been
swappiness. It is not the best interface and it has its flaws but
have you experimented with the global swappiness to express that
preference? What were your observations? Please note that the behavior
might be really different with different kernel versions so I would
really stress out that testing with the current Linus (or akpm) tree is
necessary.

Anyway, the more I think about that the more I am convinced that
explicit anon/file extension for the memory.reclaim interface is just a
wrong way to address a more fundamental underlying problem. That is, the
default reclaim choice over anon vs file preference should consider the
cost of the refaulting IO. This is more a property of the underlying
storage than a global characteristic. In other words, say you have
mutlitple storages, one that is a network based with a high latency and
other that is a local fast SSD. Reclaiming a page backed by the slower
storage is going to be more expensive to refault than the one backed by
the fast storage.  So even page cache pages are not really all the same. 

It is quite likely that a IO cost aspect is not really easy to integrate
into the memory reclaim but it seems to me this is a better way to focus
on for a better long term solution. Our existing refaulting
infrastructure should help in that respect. Also MGLRU could fit for
that purpose better than the traditional LRU based reclaim as the higher
generations could be used for more more expensive pages.
-- 
Michal Hocko
SUSE Labs

