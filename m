Return-Path: <cgroups+bounces-196-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BEA7E2E44
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 21:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4631C20840
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 20:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B6028DC6;
	Mon,  6 Nov 2023 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6B2VWxz"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C62FBEC
	for <cgroups@vger.kernel.org>; Mon,  6 Nov 2023 20:37:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6B8C0
	for <cgroups@vger.kernel.org>; Mon,  6 Nov 2023 12:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699303040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OlKBq5ACwOl3HsoTA4bZWBOpaJXjxysreGnsxwW1EII=;
	b=I6B2VWxzSZ2/UfZxWSvkGrvwX12Gmzc6qMuCxOvhZK/DtLbdboFS8kSH/2RPTRqEINQRhO
	1QhFFmSUTwXVPTAg4q0jEb9NHdaYMSTvAX0OHBM6hnqyzBS/HSoZNHamhjd84Z9gvvy9Ya
	PY//79qftXOTg+xKXwQtR8bkTIRE8c0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-eB4IiIG9MXSNphzwsxPHpg-1; Mon, 06 Nov 2023 15:37:18 -0500
X-MC-Unique: eB4IiIG9MXSNphzwsxPHpg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73918811E7E;
	Mon,  6 Nov 2023 20:37:17 +0000 (UTC)
Received: from [10.22.17.168] (unknown [10.22.17.168])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BE01B492A;
	Mon,  6 Nov 2023 20:37:16 +0000 (UTC)
Message-ID: <2212f172-def9-3ec7-b3d7-732c2b2c365e@redhat.com>
Date: Mon, 6 Nov 2023 15:37:16 -0500
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
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAJD7tkZirDce=Zq9bm_b_R=yXkj1OaqCe2ObRXzV-BtDc3X9VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 11/6/23 15:07, Yosry Ahmed wrote:
> On Fri, Nov 3, 2023 at 8:13 PM Waiman Long <longman@redhat.com> wrote:
>> The current design of cgroup_rstat_cpu_pop_updated() is to traverse
>> the updated tree in a way to pop out the leaf nodes first before
>> their parents. This can cause traversal of multiple nodes before a
>> leaf node can be found and popped out. IOW, a given node in the tree
>> can be visited multiple times before the whole operation is done. So
>> it is not very efficient and the code can be hard to read.
>>
>> With the introduction of cgroup_rstat_updated_list() to build a list
>> of cgroups to be flushed first before any flushing operation is being
>> done, we can optimize the way the updated tree nodes are being popped
>> by pushing the parents first to the tail end of the list before their
>> children. In this way, most updated tree nodes will be visited only
>> once with the exception of the subtree root as we still need to go
>> back to its parent and popped it out of its updated_children list.
>> This also makes the code easier to read.
>>
>> A parallel kernel build on a 2-socket x86-64 server is used as the
>> benchmarking tool for measuring the lock hold time. Below were the lock
>> hold time frequency distribution before and after the patch:
>>
>>       Hold time        Before patch       After patch
>>       ---------        ------------       -----------
>>         0-01 us        13,738,708         14,594,545
>>        01-05 us         1,177,194            439,926
>>        05-10 us             4,984              5,960
>>        10-15 us             3,562              3,543
>>        15-20 us             1,314              1,397
>>        20-25 us                18                 25
>>        25-30 us                12                 12
>>
>> It can be seen that the patch pushes the lock hold time towards the
>> lower end.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
> I don't know why git decided to show this diff in the most confusing
> way possible.
I agree. The diff is really hard to look at. It will be easier to apply 
the patch & looks at the actual rstat.c file.
>
>>   kernel/cgroup/rstat.c | 132 ++++++++++++++++++++++--------------------
>>   1 file changed, 70 insertions(+), 62 deletions(-)
>>
>> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
>> index 1f300bf4dc40..d2b709cfeb2a 100644
>> --- a/kernel/cgroup/rstat.c
>> +++ b/kernel/cgroup/rstat.c
>> @@ -74,64 +74,90 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
>>   }
>>
>>   /**
>> - * cgroup_rstat_cpu_pop_updated - iterate and dismantle rstat_cpu updated tree
>> - * @pos: current position
>> - * @root: root of the tree to traversal
>> + * cgroup_rstat_push_children - push children cgroups into the given list
>> + * @head: current head of the list (= parent cgroup)
>> + * @prstatc: cgroup_rstat_cpu of the parent cgroup
>>    * @cpu: target cpu
>> + * Return: A new singly linked list of cgroups to be flush
>>    *
>> - * Walks the updated rstat_cpu tree on @cpu from @root.  %NULL @pos starts
>> - * the traversal and %NULL return indicates the end.  During traversal,
>> - * each returned cgroup is unlinked from the tree.  Must be called with the
>> - * matching cgroup_rstat_cpu_lock held.
>> + * Recursively traverse down the cgroup_rstat_cpu updated tree and push
>> + * parent first before its children. The parent is pushed by the caller.
> I think it might be useful here (and elsewhere in the patch) where
> "push" is being used to elaborate that we push to the beginning in a
> stack-like fashion.
Right, I am thinking about a stack when I use the word "push". I will 
clarify that in the comment.
>
>> + * The recursion depth is the depth of the current updated tree.
>> + */
>> +static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
>> +                               struct cgroup_rstat_cpu *prstatc, int cpu)
>> +{
>> +       struct cgroup *child, *parent;
>> +       struct cgroup_rstat_cpu *crstatc;
>> +
>> +       parent = head;
>> +       child = prstatc->updated_children;
>> +       prstatc->updated_children = parent;
>> +
>> +       /* updated_next is parent cgroup terminated */
>> +       while (child != parent) {
>> +               child->rstat_flush_next = head;
>> +               head = child;
>> +               crstatc = cgroup_rstat_cpu(child, cpu);
>> +               if (crstatc->updated_children != parent)
> I think cgroup->updated_children is set to the cgroup itself if it's
> empty, right? Shouldn't this be crstatc->updated_children != child?
My mistake. Will fix it in the next version.
>
>> +                       head = cgroup_rstat_push_children(head, crstatc, cpu);
>> +               child = crstatc->updated_next;
>> +               crstatc->updated_next = NULL;
>> +       }
>> +       return head;
>> +}
>> +
>> +/**
>> + * cgroup_rstat_updated_list - return a list of updated cgroups to be flushed
>> + * @root: root of the cgroup subtree to traverse
>> + * @cpu: target cpu
>> + * Return: A singly linked list of cgroups to be flushed
>> + *
>> + * Walks the updated rstat_cpu tree on @cpu from @root.  During traversal,
>> + * each returned cgroup is unlinked from the updated tree.  Must be called
>> + * with the matching cgroup_rstat_cpu_lock held.
> This function takes care of holding the lock actually. I think that
> sentence should be applied to cgroup_rstat_push_children() above?
It is left over from before this patch. Will remove that.
>
>>    *
>>    * The only ordering guarantee is that, for a parent and a child pair
>> - * covered by a given traversal, if a child is visited, its parent is
>> - * guaranteed to be visited afterwards.
>> + * covered by a given traversal, the child is before its parent in
>> + * the list.
>> + *
>> + * Note that updated_children is self terminated while updated_next is
>> + * parent cgroup terminated except the cgroup root which can be self
>> + * terminated.
> IIUC updated_children and updated_next is the same list.
> updated_children is the head, and updated_next is how the list items
> are linked. This comment makes it seem like they are two different
> lists.
Thanks for the comment. I will rework the comment to clarify that a bit 
more.
>
> I am actually wondering if it's worth using the singly linked list
> here. We are saving 8 bytes percpu, but the semantics are fairly
> confusing. Wouldn't this be easier to reason about if you just use
> list_head?
>
> updated_children would be replaced with LIST_HEAD (or similar), and
> the list would be NULL terminated instead of terminated by self/parent
> cgroup. IIUC the reason it's not NULL-terminated now is because we use
> cgroup->updated_next to check quickly if a cgroup is on the list or
> not. If we use list_heads, we can just use list_emtpy() IIUC.
>
> We can also simplify the semantics of unlinking @root from the updated
> tree below, it would just be list_del() IIUC, which is actually more
> performant as well. It seems like overall we would simplify a lot of
> things. When forming the updated_list, we can just walk the tree and
> splice the lists in the correct order.
>
> It seems to me that saving 8 bytes percpu is not worth the complexity
> of the custom list semantics here. Am I missing something here?

It will cost an additional 16 bytes of percpu memory if converted to 
list_heads. Like other lists, there will be sibling and children 
list_heads. There are also 2 pointers to update instead of one. Anyway, 
I don't have an objection to convert them to list_heads if agreed by Tejun.

Cheers,
Longman



