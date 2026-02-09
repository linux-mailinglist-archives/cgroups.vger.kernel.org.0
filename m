Return-Path: <cgroups+bounces-13815-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCiRCcxDimn3IwAAu9opvQ
	(envelope-from <cgroups+bounces-13815-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 21:30:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EAA114783
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 21:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51446301913B
	for <lists+cgroups@lfdr.de>; Mon,  9 Feb 2026 20:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3799337B9D;
	Mon,  9 Feb 2026 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSciABx+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QI8TQC4T"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909B92459EA
	for <cgroups@vger.kernel.org>; Mon,  9 Feb 2026 20:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770668998; cv=none; b=gTNYAk6DaR7PA+rSfk//nFdqfCrCczosGKvCGXo87A/9FvluidG/eB1+PvEcZphyrFiTtE03ermngVH4OpX8OI+X9DPtkHMINtlqBQhWIiG7Z5xDqJQS89cXb5jIX0QEO353pX0p4NS5o96zGyWlU1bOS3BEb7mMglJSiW1aOMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770668998; c=relaxed/simple;
	bh=uOQ1iJTNh4itbyivBrcSFJsOviveJLlP91rw+cfXPjM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uUPgvJG7Z3nuYuCRsy5VaOcXWMufWcg34QeADhLqmNpOZUAxT+BkmAT34rO3g6HSaENh3fVej7NsDRFoZ4hkkZlcIvg4zz8VbflfeyF3kluTM+4UlP8qpeice/HUc4nNye4WmhM2J19FsZVNYvLNlTY93VQSLttjqNPKNjK22eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SSciABx+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QI8TQC4T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770668996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m144+Nm1FYBPJelch2Iyvg4dZfxN/Ng3uIUGNUMGQXE=;
	b=SSciABx+jV2wt8PsE3+MvWM3GZhQg9y0yY6CKaahnBd6z9u13cFeuVjH1XdUYR9FrUygFs
	kVOnBjuMwtX45ulX1tfZ1D6y3M1YqnUDqWZkSvDOlP2bBq9Ip3LtvE4q0uvK5qzBqVEUbZ
	x3HOjqF7eEkCJ3SqRJHQnzdpShxJxOo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-kVrjfQQyPEeuzasnDwOsDg-1; Mon, 09 Feb 2026 15:29:55 -0500
X-MC-Unique: kVrjfQQyPEeuzasnDwOsDg-1
X-Mimecast-MFC-AGG-ID: kVrjfQQyPEeuzasnDwOsDg_1770668995
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5014c472ad5so139467681cf.0
        for <cgroups@vger.kernel.org>; Mon, 09 Feb 2026 12:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770668995; x=1771273795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m144+Nm1FYBPJelch2Iyvg4dZfxN/Ng3uIUGNUMGQXE=;
        b=QI8TQC4TVYrV90pymXpkkxoy3IwZsxk9suraAcznvtipFy6O/Vp0+smZU/R2KeY8iQ
         SgkHhxeknaV0XP3awEerg4n9nbQPYeIPPePZEcA7ODzvqjJ34uGlI9UbvyPMhKkmZmSS
         NtqNVEYG3hq4Mm2Q4NyIuFgY59+HAAt6uokD+ux/MdikkwRDYVooEQPSYp2P/iXJ7pGA
         M0G8+fOZvza0NM80jYAvuoi0D4880CnQ0SCx+YgCFNAj8pBV7RQ23Qhg+ovZb1ZXtxBc
         4vEFS3bIYtdxXdi7cnEPTHSND6k6PGvwh55OlwFq1gce3jLbeUlCFk0IKRILdlFJ0jYl
         yOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770668995; x=1771273795;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m144+Nm1FYBPJelch2Iyvg4dZfxN/Ng3uIUGNUMGQXE=;
        b=GN5zqh+eAV2Ot1DrMxmLtiAK5U3dnBNmianN3d8an7JUOrpcCHz04viaviuKkX7LhP
         mwJ04tMOkMJ70mwT6yTrXUCH8wWyNpOcAChoDN9HbcfdqbQ26cjuz2JvVkOhr5nPzVkG
         1tBnQfsgw7uedulQn6yALt/DCCMSJCaYSjYPuYos4mxWn58fLSXkBk7ovlTQyNREsM2J
         p+Dx7SXGc6q5eZ6PIBpNRqY767A7nxC+AgrZL2kLg+g7JYrp6ZcvSMyX66S4yAJrmRP8
         wYkzY2JrU/HZ8tcRNoxFHzEJaaNl4YyLInMQEuBiT51MBYE7N8AqddJk12i0eGy63KYf
         0niw==
X-Gm-Message-State: AOJu0YwZ1tYZgMHcHGb6iTdI4E+k3fknCjcWjbjLsvW0pvmfKgUQZxEe
	UhVlPs134ks7fsvnn+zckY1VNnL4Szd1A6xyc0hbSWF0HKlOUREn4FbcFyKz8GelDM5Wj3dUIB9
	X4R1PveqZLfoMcA0OXQyCqsSuZsmMpg8FoBDLb7hOCct8/FtSSdLR+rZ+TDI=
X-Gm-Gg: AZuq6aLGE7Y4hiRB3hvzzvJoumzkKQlXxsIbPj3Dw94o+JIGHQXN3PQVkM4Us5oRp2g
	rvrSFrwJND88wT5Y+8J9xRosflC693Dw0Zr8fp9M0T2uvgrTsRygqlYwsvtS6c8NtkkyXYXc5CY
	JaHaUqwIUCkI8vJqZsmzxQUrP1o8l/sej/TToj/l5lIgL1YWpJcN/13cxEGDov4mS75MciLjXfv
	tr2XH4DuOVBnZdX2m75HTw8zcvZzOhUbva2D7LaagfY70dFjtzLIiXuUByHfBHjT7Irl2AwUpnj
	6HalfSnNDw7Dc3NzJe3g+U6cPj7bC0o6FDSBvU/ZC60+wSaNhszYCnkEMNvi8HCalXE/RhBIAIG
	weJAgUL/ao92o/Zgu7JvmbId3+KZrS0KZ3hnCMofU4ZJR346m9maoo1NK
X-Received: by 2002:ac8:758c:0:b0:4f1:aa2d:81cd with SMTP id d75a77b69052e-5064340d6d3mr99568331cf.65.1770668994909;
        Mon, 09 Feb 2026 12:29:54 -0800 (PST)
X-Received: by 2002:ac8:758c:0:b0:4f1:aa2d:81cd with SMTP id d75a77b69052e-5064340d6d3mr99568121cf.65.1770668994443;
        Mon, 09 Feb 2026 12:29:54 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506392c3f5esm82410191cf.26.2026.02.09.12.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 12:29:53 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <eee7862c-45ac-4acc-b8a7-a560fc21d9b4@redhat.com>
Date: Mon, 9 Feb 2026 15:29:52 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v4 3/4] cgroup/cpuset: Call housekeeping_update()
 without holding cpus_read_lock
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260206203712.1989610-1-longman@redhat.com>
 <20260206203712.1989610-4-longman@redhat.com>
 <e9c4aae2-44ed-42f5-9b4b-b63d59915143@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <e9c4aae2-44ed-42f5-9b4b-b63d59915143@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13815-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6EAA114783
X-Rspamd-Action: no action

On 2/9/26 2:12 AM, Chen Ridong wrote:
>>   		return;
>>   	}
>>   
>> -	WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
>> -	isolated_cpus_updating = false;
>> +	/*
>> +	 * update_isolation_cpumasks() may be called more than once in the
>> +	 * same cpuset_mutex critical section.
>> +	 */
>> +	lockdep_assert_held(&cpuset_top_mutex);
>> +	if (isolcpus_twork_queued)
>> +		return;
>> +
>> +	init_task_work(&twork_cb, isolcpus_tworkfn);
>> +	if (!task_work_add(current, &twork_cb, TWA_RESUME))
>> +		isolcpus_twork_queued = true;
>> +	else
>> +		WARN_ON_ONCE(1);	/* Current task shouldn't be exiting */
>>   }
>>   
> Timeline:
>
> user A			user B
> write isolated cpus	write isolated cpus
> isolated_cpus_update
> update_isolation_cpumasks
> task_work_add
> isolcpus_twork_queued =true
>
> // before returning userspace
> // waiting for worker
> 			isolated_cpus_update
> 			if (isolcpus_twork_queued)
> 				return // Early exit
> 			// return to userspace
>
> // workqueue finishes
> // return to userspace
>
> For User B, the isolated_cpus value appears to be set and the syscall returns
> successfully to userspace. However, because isolcpus_twork_queued was already
> true (set by User A), User B's call skipped the actual mask update
> (update_isolation_cpumasks).
> Thus, the new isolated_cpus value is not yet effective in the kernel, even
> though User B's write operation returned without error.
>
> Is this a valid issue? Should User B's write be blocked?

It is perfectly possible that isolated_cpus can be modified more than 
one time from different tasks before a work or task_work function is 
executed. When that function is invoked, isolated_cpus should contain 
changes for both. It will copy isolated_cpus to isolated_hk_cpus and 
pass it to housekeeping_update(). When the 2nd work or task_work 
function is invoked, it will see that isolated_cpus match 
isolated_hk_cpus and skip the housekeeping_update() action. There is no 
need to block user B's write as only one task can update isolated_cpus 
at any time.

Cheers,
Longman


