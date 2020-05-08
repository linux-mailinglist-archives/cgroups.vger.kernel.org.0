Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C001CB43B
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 18:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgEHQAW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 12:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgEHQAW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 12:00:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C860C061A0C;
        Fri,  8 May 2020 09:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=NVwFrpHFPc9V5kgayHjz15+SJTwzcU4hIq0qYBGnEGI=; b=qn0FXo6oswTaaIEy2dd0+OzYvd
        7+HkxgrTXQYH1jzmT6+IPqnXdMztANHC1nrHEO9RbIXLm4qLtj+Qnww2uFJJQdURM7RlkD3KXQrX7
        5dsdpupZgcvw4wFckC1iiwHP4MVaokpmBGoRP8infNnM9m9otmSkN5+anv/pJd3AQ7n3/YMguzUeA
        3I98i7edKgBwsVzprm0t1+R/gtDSKXdIhZCQce3Fw54j2NS088BEx4nghYD/I+QHzqhJVURpiWmuJ
        PedXdMfK/oJF6Qd502GLxkoJXH/fNsm0WNsblQGOv4GWd+7NcLhzap2hvoZnvD5lowztzo8sUbpK2
        DjFcBNiQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX5Q8-0002vu-RN; Fri, 08 May 2020 16:00:16 +0000
Subject: Re: [PATCH] doc: cgroup: update note about conditions when oom killer
 is invoked
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@suse.com>
References: <158894738928.208854.5244393925922074518.stgit@buzz>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b0242e17-c436-747a-8403-d263a16553d0@infradead.org>
Date:   Fri, 8 May 2020 09:00:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <158894738928.208854.5244393925922074518.stgit@buzz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 5/8/20 7:16 AM, Konstantin Khlebnikov wrote:
> Starting from v4.19 commit 29ef680ae7c2 ("memcg, oom: move out_of_memory
> back to the charge path") cgroup oom killer is no longer invoked only from
> page faults. Now it implements the same semantics as global OOM killer:
> allocation context invokes OOM killer and keeps retrying until success.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |   17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index bcc80269bb6a..1bb9a8f6ebe1 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1172,6 +1172,13 @@ PAGE_SIZE multiple when read back.
>  	Under certain circumstances, the usage may go over the limit
>  	temporarily.
>  
> +	In default configuration regular 0-order allocation always

	                                         allocations

> +	succeed unless OOM killer choose current task as a victim.

	                          chooses

> +
> +	Some kinds of allocations don't invoke the OOM killer.
> +	Caller could retry them differently, return into userspace
> +	as -ENOMEM or silently ignore in cases like disk readahead.
> +
>  	This is the ultimate protection mechanism.  As long as the
>  	high limit is used and monitored properly, this limit's
>  	utility is limited to providing the final safety net.
> @@ -1228,17 +1235,9 @@ PAGE_SIZE multiple when read back.
>  		The number of time the cgroup's memory usage was
>  		reached the limit and allocation was about to fail.
>  
> -		Depending on context result could be invocation of OOM
> -		killer and retrying allocation or failing allocation.
> -
> -		Failed allocation in its turn could be returned into
> -		userspace as -ENOMEM or silently ignored in cases like
> -		disk readahead.  For now OOM in memory cgroup kills
> -		tasks iff shortage has happened inside page fault.
> -
>  		This event is not raised if the OOM killer is not
>  		considered as an option, e.g. for failed high-order
> -		allocations.
> +		allocations or if caller asked to not retry attempts.
>  
>  	  oom_kill
>  		The number of processes belonging to this cgroup
> 


thanks for updating the docs.
-- 
~Randy

