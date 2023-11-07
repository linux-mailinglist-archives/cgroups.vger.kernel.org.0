Return-Path: <cgroups+bounces-212-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E077E41CB
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 15:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310D01C20BE2
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 14:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C74B30FB4;
	Tue,  7 Nov 2023 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IO5cygva"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4884630F8E
	for <cgroups@vger.kernel.org>; Tue,  7 Nov 2023 14:28:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83557F3
	for <cgroups@vger.kernel.org>; Tue,  7 Nov 2023 06:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699367299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bNQ+oSJdAKlj112KqZpYcKdvdbIM8q4fdKZ55QZepF8=;
	b=IO5cygvaFxq0d0++PjcyMxzVpdwnDPLe74ehYROIiK27XnEIpAs6C2dywxTcNgM9kdLCJ9
	y8VTA8cW8W8YmJyQ8biqshl/UrxgP2P2c2mi0/pPJE5pfsaC0XPqqD5yL8PtlpW0YUbjVC
	gltHDgDl/wAVo33LUYytH3PEdyKEy64=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-AZo6obRgMqizZJnc_LNJng-1; Tue, 07 Nov 2023 09:28:17 -0500
X-MC-Unique: AZo6obRgMqizZJnc_LNJng-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC3BB185A780;
	Tue,  7 Nov 2023 14:28:15 +0000 (UTC)
Received: from [10.22.32.17] (unknown [10.22.32.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B9E041C060AE;
	Tue,  7 Nov 2023 14:28:14 +0000 (UTC)
Message-ID: <659cc4ae-ca1e-fd97-b6e5-211738f7b7b9@redhat.com>
Date: Tue, 7 Nov 2023 09:28:14 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/3] cgroup/rstat: Optimize cgroup_rstat_updated_list()
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
 Sebastian Jug <sejug@redhat.com>
References: <20231104031303.592879-1-longman@redhat.com>
 <20231104031303.592879-3-longman@redhat.com>
 <CAJD7tkZirDce=Zq9bm_b_R=yXkj1OaqCe2ObRXzV-BtDc3X9VQ@mail.gmail.com>
 <2212f172-def9-3ec7-b3d7-732c2b2c365e@redhat.com>
 <CAJD7tkYmSAg_T289jRczARsXu2sCW0GrR9VPyL04fQRKzCK0hg@mail.gmail.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAJD7tkYmSAg_T289jRczARsXu2sCW0GrR9VPyL04fQRKzCK0hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 11/6/23 16:17, Yosry Ahmed wrote:
> On Mon, Nov 6, 2023 at 12:37 PM Waiman Long <longman@redhat.com> wrote:
>> On 11/6/23 15:07, Yosry Ahmed wrote:
>>> On Fri, Nov 3, 2023 at 8:13 PM Waiman Long <longman@redhat.com> wrote:
>>>> The current design of cgroup_rstat_cpu_pop_updated() is to traverse
>>>> the updated tree in a way to pop out the leaf nodes first before
>>>> their parents. This can cause traversal of multiple nodes before a
>>>> leaf node can be found and popped out. IOW, a given node in the tree
>>>> can be visited multiple times before the whole operation is done. So
>>>> it is not very efficient and the code can be hard to read.
>>>>
>>>> With the introduction of cgroup_rstat_updated_list() to build a list
>>>> of cgroups to be flushed first before any flushing operation is being
>>>> done, we can optimize the way the updated tree nodes are being popped
>>>> by pushing the parents first to the tail end of the list before their
>>>> children. In this way, most updated tree nodes will be visited only
>>>> once with the exception of the subtree root as we still need to go
>>>> back to its parent and popped it out of its updated_children list.
>>>> This also makes the code easier to read.
>>>>
>>>> A parallel kernel build on a 2-socket x86-64 server is used as the
>>>> benchmarking tool for measuring the lock hold time. Below were the lock
>>>> hold time frequency distribution before and after the patch:
>>>>
>>>>        Hold time        Before patch       After patch
>>>>        ---------        ------------       -----------
>>>>          0-01 us        13,738,708         14,594,545
>>>>         01-05 us         1,177,194            439,926
>>>>         05-10 us             4,984              5,960
>>>>         10-15 us             3,562              3,543
>>>>         15-20 us             1,314              1,397
>>>>         20-25 us                18                 25
>>>>         25-30 us                12                 12
>>>>
>>>> It can be seen that the patch pushes the lock hold time towards the
>>>> lower end.
>>>>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> ---
>>> I don't know why git decided to show this diff in the most confusing
>>> way possible.
>> I agree. The diff is really hard to look at. It will be easier to apply
>> the patch & looks at the actual rstat.c file.
> Would the diff be simpler if patches 1 & 2 were squashed?
Maybe, but I prefer to keep them separate for now.
>
> [..]
>>>>     *
>>>>     * The only ordering guarantee is that, for a parent and a child pair
>>>> - * covered by a given traversal, if a child is visited, its parent is
>>>> - * guaranteed to be visited afterwards.
>>>> + * covered by a given traversal, the child is before its parent in
>>>> + * the list.
>>>> + *
>>>> + * Note that updated_children is self terminated while updated_next is
>>>> + * parent cgroup terminated except the cgroup root which can be self
>>>> + * terminated.
>>> IIUC updated_children and updated_next is the same list.
>>> updated_children is the head, and updated_next is how the list items
>>> are linked. This comment makes it seem like they are two different
>>> lists.
>> Thanks for the comment. I will rework the comment to clarify that a bit
>> more.
>>> I am actually wondering if it's worth using the singly linked list
>>> here. We are saving 8 bytes percpu, but the semantics are fairly
>>> confusing. Wouldn't this be easier to reason about if you just use
>>> list_head?
>>>
>>> updated_children would be replaced with LIST_HEAD (or similar), and
>>> the list would be NULL terminated instead of terminated by self/parent
>>> cgroup. IIUC the reason it's not NULL-terminated now is because we use
>>> cgroup->updated_next to check quickly if a cgroup is on the list or
>>> not. If we use list_heads, we can just use list_emtpy() IIUC.
>>>
>>> We can also simplify the semantics of unlinking @root from the updated
>>> tree below, it would just be list_del() IIUC, which is actually more
>>> performant as well. It seems like overall we would simplify a lot of
>>> things. When forming the updated_list, we can just walk the tree and
>>> splice the lists in the correct order.
>>>
>>> It seems to me that saving 8 bytes percpu is not worth the complexity
>>> of the custom list semantics here. Am I missing something here?
>> It will cost an additional 16 bytes of percpu memory if converted to
>> list_heads. Like other lists, there will be sibling and children
>> list_heads. There are also 2 pointers to update instead of one. Anyway,
>> I don't have an objection to convert them to list_heads if agreed by Tejun.
> Yes you are right. It's definitely not free, but it's also not super
> costly. It's just that every time I look at the rstat code I need to
> remind myself of how updated_next and updated_children work. I will
> let Tejun decide.

After further thought, changing it to list_head may not be possible with 
the current design since the actual linkage is like:

update_next -> cgroup + cpu --> update_next --> ...

So unless we change the design to link cgroup_rstat_cpu directly to each 
other for a given CPU, not via a cgroup intermediary, we will not be 
able to use list_head and the associated list_add() & list_del() macros. 
Direct linkage, however, requires a cgroup back pointer. So the real 
cost will be 24 bytes instead.

Cheers,
Longman


