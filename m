Return-Path: <cgroups+bounces-247-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A222C7E5854
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 15:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5815F2813E7
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 14:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BE3199AE;
	Wed,  8 Nov 2023 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CTsg3fLL"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABB6199B9;
	Wed,  8 Nov 2023 14:06:51 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65CF1BEF;
	Wed,  8 Nov 2023 06:06:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E884C21941;
	Wed,  8 Nov 2023 14:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1699452408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LaClYnaw6igUxX7esICB56ZTaW9lZv4RiLl36XDtkh8=;
	b=CTsg3fLLzBHl2568mWukL8T40aLJF31TtuAhYR2Jcpfw/k32BffM1bMFFvdei6L2mS4B5g
	cTnaeoB1LPbVjfBLO7WedjjyNuiUnin5QykKZyH9JGPnRS8i7GqRAvMGikKGEYK1a0NpWD
	tjCqQvf45TTzHllizF6QAnVTW+wCqFo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5233133F5;
	Wed,  8 Nov 2023 14:06:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id uvYvLfiVS2U7XAAAMHmgww
	(envelope-from <mhocko@suse.com>); Wed, 08 Nov 2023 14:06:48 +0000
Date: Wed, 8 Nov 2023 15:06:47 +0100
From: Michal Hocko <mhocko@suse.com>
To: Huan Yang <link@vivo.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Xu <peterx@redhat.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Liu Shixin <liushixin2@huawei.com>, Hugh Dickins <hughd@google.com>,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	opensource.kernel@vivo.com
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
Message-ID: <ZUuV9xOZ5k7Ia_V2@tiehlicka>
References: <20231108065818.19932-1-link@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108065818.19932-1-link@vivo.com>

On Wed 08-11-23 14:58:11, Huan Yang wrote:
> In some cases, we need to selectively reclaim file pages or anonymous
> pages in an unbalanced manner.
> 
> For example, when an application is pushed to the background and frozen,
> it may not be opened for a long time, and we can safely reclaim the
> application's anonymous pages, but we do not want to touch the file pages.

Could you explain why? And also why do you need to swap out in that
case?
 
> This patchset extends the proactive reclaim interface to achieve
> unbalanced reclamation. Users can control the reclamation tendency by
> inputting swappiness under the original interface. Specifically, users
> can input special values to extremely reclaim specific pages.

Other have already touched on this in other replies but v2 doesn't have
a per-memcg swappiness

> Example:
>   	echo "1G" 200 > memory.reclaim (only reclaim anon)
> 	  echo "1G" 0  > memory.reclaim (only reclaim file)
> 	  echo "1G" 1  > memory.reclaim (only reclaim file)
> 
> Note that when performing unbalanced reclamation, the cgroup swappiness
> will be temporarily adjusted dynamically to the input value. Therefore,
> if the cgroup swappiness is further modified during runtime, there may
> be some errors.

In general this is a bad semantic. The operation shouldn't have side
effect that are potentially visible for another operation.
-- 
Michal Hocko
SUSE Labs

