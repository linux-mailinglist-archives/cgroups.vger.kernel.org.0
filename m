Return-Path: <cgroups+bounces-3504-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D04924846
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 21:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B022E1F2198C
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 19:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3101CE08D;
	Tue,  2 Jul 2024 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W2dJEYBN"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3AB1CD5BD
	for <cgroups@vger.kernel.org>; Tue,  2 Jul 2024 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948487; cv=none; b=fqySRamLhQPbBNPA9s3KXe01yNpcHP6QtjN1gSsmIDIxlv8Y1vM50TgrwhheQrpk4jGQSV0N84sPTVgukVOd3AOpNlSgJGOvzAJhPbujpNbw3SiJq5yfoF/bduvtuUycyyTd/R+TlnxidCTY1j4hhCyEsKk4pJeqSGgwmpOiFoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948487; c=relaxed/simple;
	bh=T24o6Ajs/+82yw3wIvMIKCDND79Fa1BVu1Oj8G7eHaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uq2iepDdYwjXnTZ8T8vZGxtOoBiMjHSjHi2iKDHuMUuqXsM7r04uqq5v3N7a+U4oAFiqiIoj8bFiydnqsDs5JicmnVI9Flwb6n+uMHwDt11ywbLX748zyQASh7B/LQ7Yze971LwgjVfF5fUdb+tS3LFkBvT8TJZtPjJ8AIzig7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W2dJEYBN; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: link@vivo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719948482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hojp0DeSg4Ixj48tcE2WeffeK1tRtWxICSSIIGexTDc=;
	b=W2dJEYBNeSo6u8zzBmvyF8uBBxS70B+MA1/UR+gobWa2dc4EuPzHQ8y27i9mEJpI9c8pys
	W+qKa1uVE3ROgsYaf1jry5M7mR4J3Vhj3ImsCQ4gWnN16LQXJudwnUsoeLuzLUxbCK/Fxy
	qRWKBcptOEz4zQOAH6djOObkQCpy3NU=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: david@redhat.com
X-Envelope-To: ryan.roberts@arm.com
X-Envelope-To: chrisl@kernel.org
X-Envelope-To: schatzberg.dan@gmail.com
X-Envelope-To: kasong@tencent.com
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: brauner@kernel.org
X-Envelope-To: opensource.kernel@vivo.com
Date: Tue, 2 Jul 2024 19:27:54 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Huan Yang <link@vivo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Chris Li <chrisl@kernel.org>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Kairui Song <kasong@tencent.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, opensource.kernel@vivo.com
Subject: Re: [RFC PATCH 0/4] Introduce PMC(PER-MEMCG-CACHE)
Message-ID: <ZoRUukQUNqGHn_x1@google.com>
References: <20240702084423.1717904-1-link@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702084423.1717904-1-link@vivo.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 02, 2024 at 04:44:03PM +0800, Huan Yang wrote:
> This patchset like to talk abount a idea about PMC(PER-MEMCG-CACHE).
> 
> Background
> ===
> 
> Modern computer systems always have performance gaps between hardware,
> such as the performance differences between CPU, memory, and disk.
> Due to the principle of locality of reference in data access:
> 
>   Programs often access data that has been accessed before
>   Programs access the next set of data after accessing a particular data
> As a result:
>   1. CPU cache is used to speed up the access of already accessed data
>      in memory
>   2. Disk prefetching techniques are used to prepare the next set of data
>      to be accessed in advance (to avoid direct disk access)
> The basic utilization of locality greatly enhances computer performance.
> 
> PMC (per-MEMCG-cache) is similar, utilizing a principle of locality to enhance
> program performance.
> 
> In modern computers, especially in smartphones, services are provided to
> users on a per-application basis (such as Camera, Chat, etc.),
> where an application is composed of multiple processes working together to
> provide services.
> 
> The basic unit for managing resources in a computer is the process,
> which in turn uses threads to share memory and accomplish tasks.
> Memory is shared among threads within a process.
> 
> However, modern computers have the following issues, with a locality deficiency:
> 
>   1. Different forms of memory exist and are not interconnected (anonymous
>      pages, file pages, special memory such as DMA-BUF, various memory alloc in
>      kernel mode, etc.)
>   2. Memory isolation exists between processes, and apart from specific
>      shared memory, they do not communicate with each other.
>   3. During the transition of functionality within an application, a process
>      usually releases memory, while another process requests memory, and in
>      this process, memory has to be obtained from the lowest level through
>      competition.
> 
> For example abount camera application:
> 
> Camera applications typically provide photo capture services as well as photo
> preview services.
> The photo capture process usually utilizes DMA-BUF to facilitate the sharing
> of image data between the CPU and DMA devices.
> When it comes to image preview, multiple algorithm processes are typically
> involved in processing the image data, which may also involve heap memory
> and other resources.
> 
> During the switch between photo capture and preview, the application typically
> needs to release DMA-BUF memory and then the algorithms need to allocate
> heap memory. The flow of system memory during this process is managed by
> the PCP-BUDDY system.
> 
> However, the PCP and BUDDY systems are shared, and subsequently requested
> memory may not be available due to previously allocated memory being used
> (such as for file reading), requiring a competitive (memory reclamation)
> process to obtain it.
> 
> So, if it is possible to allow the released memory to be allocated with
> high priority within the application, then this can meet the locality
> requirement, improve performance, and avoid unnecessary memory reclaim.
> 
> PMC solutions are similar to PCP, as they both establish cache pools according
> to certain rules.
> 
> Why base on MEMCG?
> ===
> 
> The MEMCG container can allocate selected processes to a MEMCG based on certain
> grouping strategies (typical examples include grouping by app or UID).
> Processes within the same MEMCG can then be used for statistics, upper limit
> restrictions, and reclamation control.
> 
> All processes within a MEMCG are considered as a single memory unit,
> sharing memory among themselves. As a result, when one process releases
> memory, another process within the same group can obtain it with the
> highest priority, fully utilizing the locality of memory allocation
> characteristics within the MEMCG (such as APP grouping).
> 
> In addition, MEMCG provides feature interfaces that can be dynamically toggled
> and are fully controllable by the policy.This provides greater flexibility
> and does not impact performance when not enabled (controlled through static key).
> 
> 
> Abount PMC implement
> ===
> Here, a cache switch is provided for each MEMCG(not on root).
> When the user enables the cache, processes within the MEMCG will share memory
> through this cache.
> 
> The cache pool is positioned before the PCP. All order0 page released by
> processes in MEMCG will be released to the cache pool first, and when memory
> is requested, it will also be prioritized to be obtained from the cache pool.
> 
> `memory.cache` is the sole entry point for controlling PMC, here are some
> nested keys to control PMC:
>   1. "enable=[y|n]" to enable or disable targeted MEMCG's cache
>   2. "keys=nid=%d,watermark=%u,reaper_time=%u,limit=%u" to control already
>   enabled PMC's behavior.
>     a) `nid` to targeted a node to change it's key. or else all node.
>     b) The `watermark` is used to control cache behavior, caching only when
>        zone free pages above the zone's high water mark + this watermark is
>        exceeded during memory release. (unit byte, default 50MB,
>        min 10MB per-node-all-zone)
>     c) `reaper_time` to control reaper gap, if meet, reaper all cache in this
>         MEMCG(unit us, default 5s, 0 is disable.)
>     d) `limit` is to limit the maximum memory used by the cache pool(unit bytes,
>        default 100MB, max 500MB per-node-all-zone)
> 
> Performance
> ===
> PMC is based on MEMCG and requires performance measurement through the
> sharing of complex workloads between application processes.
> Therefore, at the moment, we unable to provide a better testing solution
> for this patchset.
> 
> Here is the internal testing situation we provide, using the camera
> application as an example. (1-NODE-1-ZONE-8GRAM)
> 
> Test Case: Capture in rear portrait HDR mode
> 1. Test mode: rear portrait HDR mode. This scene needs more than 800M ram
>    which memory types including dmabuf(470M), PSS(150M) and APU(200M)
> 2. Test steps: take a photo, then click thumbnail to view the full image
> 
> The overall performance benefit from click shutter button to showing whole
> image improves 500ms, and the total slowpath cost of all camera threads reduced
> from 958ms to 495ms. 
> Especially for the shot2shot in this mode, the preview dealy of each frame have
> a significant improve.

Hello Huan,

thank you for sharing your work.

Some high-level thoughts:
1) Naming is hard, but it took me quite a while to realize that you're talking
about free memory. Cache is obviously an overloaded term, but per-memcg-cache
can mean absolutely anything (pagecache? cpu cache? ...), so maybe it's not
the best choice.
2) Overall an idea to have a per-memcg free memory pool makes sense to me,
especially if we talk 2MB or 1GB pages (or order > 0 in general).
3) You absolutely have to integrate the reclaim mechanism with a generic
memory reclaim mechanism, which is driven by the memory pressure.
4) You claim a ~50% performance win in your workload, which is a lot. It's not
clear to me where it's coming from. It's hard to believe the page allocation/release
paths are taking 50% of the cpu time. Please, clarify.

There are a lot of other questions, and you highlighted some of them below
(and these are indeed right questions to ask), but let's start with something.

Thanks

