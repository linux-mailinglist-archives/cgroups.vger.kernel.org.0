Return-Path: <cgroups+bounces-602-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB527FBF76
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 17:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5891C20C80
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 16:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533723529B;
	Tue, 28 Nov 2023 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmnqX3wa"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4603AD6
	for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 08:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701189981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QtguvXmgcADMzdVOD2VT2BOnlg+LybpKeuHvVA1rDbs=;
	b=LmnqX3waLg8masx5L8zcUUIY9Ix/nI4GAD1ruhQeGGrur69/081DERL8QTS0bjz6osrEYW
	iqTgl23RIGDOvgOdSVzLcNF74ersWcMd9f93Slu6jifN7J42zBA5yydpPqonASBc4wij8w
	gXbvzvOUgVan4rqXB4HR69XDlxC3wZ4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-oPxxcZXpPHmDlMsvbvZYeg-1; Tue,
 28 Nov 2023 11:46:19 -0500
X-MC-Unique: oPxxcZXpPHmDlMsvbvZYeg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D97273C0FC8B;
	Tue, 28 Nov 2023 16:46:18 +0000 (UTC)
Received: from [10.22.17.248] (unknown [10.22.17.248])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 55AAB20268DA;
	Tue, 28 Nov 2023 16:46:18 +0000 (UTC)
Message-ID: <708eda13-6615-4efe-87e1-f3610e90e116@redhat.com>
Date: Tue, 28 Nov 2023 11:46:18 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] cgroup/rstat: Optimize cgroup_rstat_updated_list()
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Joe Mario <jmario@redhat.com>, Sebastian Jug <sejug@redhat.com>,
 Yosry Ahmed <yosryahmed@google.com>
References: <20231106210543.717486-1-longman@redhat.com>
 <20231106210543.717486-3-longman@redhat.com>
 <a9aa2809-95f5-4f60-b936-0d857c971fea@redhat.com>
 <ZWYYrJVMUOrl9r2g@slm.duckdns.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZWYYrJVMUOrl9r2g@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 11/28/23 11:43, Tejun Heo wrote:
> On Mon, Nov 27, 2023 at 11:01:22PM -0500, Waiman Long wrote:
> ...
>>> + * Recursively traverse down the cgroup_rstat_cpu updated tree and push
>>> + * parent first before its children into a singly linked list built from
>>> + * the tail backward like "pushing" cgroups into a stack. The parent is
>>> + * pushed by the caller. The recursion depth is the depth of the current
>>> + * updated subtree.
>>> + */
>>> +static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
>>> +				struct cgroup_rstat_cpu *prstatc, int cpu)
>>> +{
>>> +	struct cgroup *child, *parent;
>>> +	struct cgroup_rstat_cpu *crstatc;
>>> +
>>> +	parent = head;
>>> +	child = prstatc->updated_children;
>>> +	prstatc->updated_children = parent;
>>> +
>>> +	/* updated_next is parent cgroup terminated */
>>> +	while (child != parent) {
>>> +		child->rstat_flush_next = head;
>>> +		head = child;
>>> +		crstatc = cgroup_rstat_cpu(child, cpu);
>>> +		if (crstatc->updated_children != child)
>>> +			head = cgroup_rstat_push_children(head, crstatc, cpu);
>>> +		child = crstatc->updated_next;
>>> +		crstatc->updated_next = NULL;
>>> +	}
>>> +	return head;
> The recursion bothers me. We don't really have a hard limit on nesting
> depth. We might need to add another pointer field but can make this
> iterative, right?

I see. Yes, I think it is possible to make it iterative. Using recursion 
is just an easier way to do it. Will look into that.

Thanks,
Longman

>
> Thanks.
>


