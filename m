Return-Path: <cgroups+bounces-15774-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB3NA4wcAmocoAEAu9opvQ
	(envelope-from <cgroups+bounces-15774-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:14:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6644D5142C4
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A3A330E01B2
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 17:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202AC477988;
	Mon, 11 May 2026 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqCelkhF"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D9C47AF5F
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522100; cv=none; b=m4CK1jQ69mKfLl3J/QV6QVzahwZPLRSonnVBO+WUJBf8RWzCJRH8F+aU4OxTm5krw5ocOQ08pl4lxb9JK5KJXtdJKwcVEig/Ocfo47oIGLP9bJ4bU4+4AfSuv32puzvw6IXutU1B4/DAuWlQ01PwyI7khrRurkINKG8t5GQqeVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522100; c=relaxed/simple;
	bh=0iTg+leX0j2qT7Fm8ZWc0NcP/PDd5Medeqon2RI8VYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HIrwLTeoUSaEc6nZ3AyBClMOU8zUE/HCDCWn8d8AFd7htetGPHswgL8qGbTssgL5t3MnfPnxX3gN5q3Jzrzg+hz1RcBaBmjopfGEeejgZCq9JdYUn4thpnWp2VHDNXdnJv+0GDlmLkOUWUd/wbzpvQZoLcOzrkje30FFRM1kk38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gqCelkhF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778522097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKvjdJ57xbDNtz0/ef8xqKSCc51OBN1WOr77UzgegmY=;
	b=gqCelkhFn/oPa8i1CqIq4ufTi+S7lI+NIDtt49dnjidfKAMM3lgezEQbtwbopfebTW/r3i
	zPt6UKBayCidnallFNvhNe4nP1t4NYaTmuQZHY1/RZZuNc4o/GCfINmg79NuL/GCqtZlbO
	4qQ4yGBQcANhY6B3/4tRD1/euA83yKI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-DDlwY3Z8OlqsCjfisEs3DA-1; Mon,
 11 May 2026 13:54:54 -0400
X-MC-Unique: DDlwY3Z8OlqsCjfisEs3DA-1
X-Mimecast-MFC-AGG-ID: DDlwY3Z8OlqsCjfisEs3DA_1778522090
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D5941956080;
	Mon, 11 May 2026 17:54:49 +0000 (UTC)
Received: from [10.2.17.16] (unknown [10.2.17.16])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F33B18004A3;
	Mon, 11 May 2026 17:54:39 +0000 (UTC)
Message-ID: <354af9fc-1c70-4ee4-a0ff-8821bebec7b8@redhat.com>
Date: Mon, 11 May 2026 13:54:37 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cgroup/cpuset: Fix deadline bandwidth leak in
 cpuset_can_attach()
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: tsbogend@alpha.franken.de, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 stephen.smalley.work@gmail.com, casey@schaufler-ca.com, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, chenridong@huaweicloud.com,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
 omosnace@redhat.com, kees@kernel.org, neelx@suse.com, sean@ashe.io,
 chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, nick.lange@gmail.com,
 cgroups@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260509164847.939294-1-atomlin@atomlin.com>
 <20260509164847.939294-2-atomlin@atomlin.com>
 <8aaa7dd9-2426-475c-af64-85ef5f2aa855@redhat.com>
 <aihz6zlfmcaxwb3ef4luisfpwqibwsajpphy5vzuksy3ftfkms@whhv2ax5plpb>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <aihz6zlfmcaxwb3ef4luisfpwqibwsajpphy5vzuksy3ftfkms@whhv2ax5plpb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 6644D5142C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15774-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[alpha.franken.de,paul-moore.com,namei.org,hallyn.com,redhat.com,infradead.org,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com,huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,amd.com,ashe.io,abita.co,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/11/26 7:08 AM, Aaron Tomlin wrote:
> On Mon, May 11, 2026 at 01:10:02AM -0400, Waiman Long wrote:
>> On 5/9/26 12:48 PM, Aaron Tomlin wrote:
>>> During a cgroup migration, cpuset_can_attach() iterates over the
>>> provided taskset. If a task within the batch is a deadline (DL) task,
>>> the destination cpuset's DL metrics (i.e., nr_migrate_dl_tasks and
>>> sum_migrate_dl_bw) are appropriately incremented.
>>>
>>> However, if a subsequent task in the same migration batch fails the
>>> task_can_attach() check, the loop aborts and jumps directly to
>>> out_unlock. Consequently, any DL metrics accumulated from previously
>>> processed tasks in the batch remain permanently inflated in the
>>> destination cpuset. Because the migration is subsequently aborted by the
>>> cgroup core, cpuset_cancel_attach() is never invoked to unwind these
>>> specific increments.
>>>
>>> This behaviour results in a permanent leak of deadline bandwidth, which
>>> incorrectly restricts the admission control capacity of the destination
>>> cpuset.
>>>
>>> To resolve this, introduce an out_unlock_reset failure path that
>>> conditionally invokes reset_migrate_dl_data(). This guarantees that if a
>>> batch migration is aborted for any reason, the pending DL metrics are
>>> safely reset before returning the error.
>>>
>>> Fixes: 0a67b847e1f06 ("cpuset: Allow setscheduler regardless of manipulated task")
>> That is not the commit that introduced the bug. Anyway, there is already
>> another patch sent recently to fix this bug. See
>>
>> https://lore.kernel.org/lkml/20260509102031.97608-2-zhangguopeng@kylinos.cn/
>>
> Hi Waiman,
>
> Thank you for the follow up.
>
> Acknowledged. I will drop this patch in the next iteration due to [1].
>
> Please note, the sashiko AI Review bot reported: cpuset_can_attach()
> incorrectly assumes all migrating tasks originate from the same source
> cpuset. At first glance, this feedback is valid. I plan to submit a patch,
> if no solution was already proposed.
>
> [1]: https://lore.kernel.org/lkml/20260509102031.97608-2-zhangguopeng@kylinos.cn/

Yes, it does look like the AI feedback is valid. I will take a further 
look into this.

Thanks,
Longman


