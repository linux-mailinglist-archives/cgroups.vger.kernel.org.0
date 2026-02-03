Return-Path: <cgroups+bounces-13617-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPBlMIFHgWkZFQMAu9opvQ
	(envelope-from <cgroups+bounces-13617-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 01:55:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAB8D32C0
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 01:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29B143013796
	for <lists+cgroups@lfdr.de>; Tue,  3 Feb 2026 00:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4764C21765B;
	Tue,  3 Feb 2026 00:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvkCGJ+B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hq9mKo9d"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0BA1F75A6
	for <cgroups@vger.kernel.org>; Tue,  3 Feb 2026 00:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770080121; cv=none; b=LnGZ5+2Ur241l/cYrc+bzcXuMFNEa2uBYxibq5HIBt5eb3SsoAQ7d9waLG37Y6ngnOn2RaEWSW9LajXT9WoCOlBxS2dgIic5DtCDoPFVBEptXhWzNhdUZ7V68auFggPAgQWMsdDBpORvkE59g2hmTeMidm9DhqVP0dChj7sbPTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770080121; c=relaxed/simple;
	bh=l2d5M5deI1WzO0QOi7x/Hlx8HVvtkMiABKSYrRxMGgk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HY4+XfH2aE5i0I6phn8Y9gWB2kwyx8ss6Lbzc/7v88n5rbLaskqm0enbbqIy+/95dFir7/JIsyGOvG1lrXi8Rw53yUDWxOujO99KAc73AY0jZYGa/tXLuylcGHqtKOjELKy4OYMf6BF72/NMedetUoICR4/k3Qu1uVG070o/pN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JvkCGJ+B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hq9mKo9d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770080118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SjIr2kFnG9dRMyzn5Xr9r8FTYW/SoLc0im+4o9BZWhg=;
	b=JvkCGJ+BcsRM0dqTsgYh1J4OORhot+wrgWEkRSm4lxEv2oR7aC2r2KfRkiVgegcTeU8ZYw
	5b++rWorAvsFom1jMj8xezgeYxpmwFYRChthncOGy8TR7MX3Y3HxUoVdwSCd4aAKMizSrv
	hoQfRiMqs1MKW14zyG8HxADO4eJCrdo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-8FdXOsMDPJaHx0qkViuk4g-1; Mon, 02 Feb 2026 19:55:17 -0500
X-MC-Unique: 8FdXOsMDPJaHx0qkViuk4g-1
X-Mimecast-MFC-AGG-ID: 8FdXOsMDPJaHx0qkViuk4g_1770080117
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50148a2a5baso154538951cf.2
        for <cgroups@vger.kernel.org>; Mon, 02 Feb 2026 16:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770080117; x=1770684917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SjIr2kFnG9dRMyzn5Xr9r8FTYW/SoLc0im+4o9BZWhg=;
        b=Hq9mKo9daIdZ/VPMQD8p5Cjf8gPgBo4oudbbVrtBnYkrvcedDXABdPLd/t9c9jnFfx
         Cglok7pxC0UdMneFDhIJuFLMasaZk3Erllx8QlChr4mBTdqOhWNv1KBd5URmg5rIz2U7
         yjVid3ibCuZktGhnUmgvY4HQCqroqI4xTqfYTIKKQ19Nh1hRnd0Cr66BzWqIOvFhSd82
         txFea1eGRfK6aXBT1jbZRwOJssYYXJEhlmVyn9oEpuin2vGdO56HV9s3tvab2sV/n7yv
         gLc4btIfUqR9DVXjGRvJOKUsAzuYSMmJ17g1LMLj7W+CMpJkia5TfVPp3dE01/uFKB37
         B7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770080117; x=1770684917;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SjIr2kFnG9dRMyzn5Xr9r8FTYW/SoLc0im+4o9BZWhg=;
        b=oPGyXIEeuYquPJzEh/2pmXTtF2XyL9WvAY6a/SVHfIMjHfv79SpjqYLYDjA7t1gID5
         o9zwgy35Yi9emx+WTULbGzUnUsG9iOWM4RqMgcNdNAViRW2gmCg0ZArzeMn99cD59dCr
         o/yF8IoIVuvc0GGzhJ/fvzakXHEkLN1zEqtVAlIeankfHwwTOsIhEWvNvXkrDBspoT3B
         a3s7ThkI+mK7KCXkI1ycJvvLacPIui94nwNIZIRHW2fcIwxgp34QKcVgMz5RpynKnQjb
         L1yk+M5BzYGFtthPbsyVBJ5rmN1+KQx63XUYAWzLCedTpNYgCNfjo7DjQnBov1ePVnTJ
         gJlA==
X-Forwarded-Encrypted: i=1; AJvYcCVpaC70wdA0HR+F8XGW5aFNDI3fEGPOdT1K1hVJ93nhHg51kzlIstgav31ga7h0RasIlDz4/95B@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1zp5OCpJXq+apl3sPHRMT/vliK5ij9vNqVyIhjR5ViX67iWqt
	fDfmvjjPtDodgDxVKusvOyAkGJ8d6YbZ3hYCZs3iZA9jXlYn6KHPhveEUcxSZ5AymsHFouGynoY
	bU6ocr8sjif1Gh0c5HG6VqvilEFdtA/Wd15mFfi8vo0Lu4oiw0UvGLJrybog=
X-Gm-Gg: AZuq6aIe7hTWlN6gEK3yFqF8ajn4RquRCLV+F9+eJ8xtD+3y0Zuspxg5j9ENm3diO8V
	c1jtJ07fsdEEcJ5KXQlwKpDB+dVHKfP+idZDqmnbh4/HRCuCZULlwY+ZYVQDVV0BrwPt/1d/lSe
	IqDc5DkuG9I8eLpHnJXbEavUakX6m6QykpR5hu5uNuykUZQ74/dK4skkdSPOgeZtdzMXQNxdLRk
	iaPVyagDyqMbLqEuXgNroisEFFSV/MdSfaoRuaQDegNbKy7A1LWD0nzQsp4K5CqCSlhZVvy7V1k
	uTChHXWvg5VlZ+pyOVGE9zXRK4ui8zFAycwT2392voJ5of/mk1Eo1RGmC4vO6NY2Gad47weqvJs
	HiXQrJ4ylEQNhmEiyvJ1qzP3pUapb8kPD+umz56OQXdQf9OGmLznxQZiw
X-Received: by 2002:a05:622a:1308:b0:502:a100:4054 with SMTP id d75a77b69052e-505d217d0a4mr175263501cf.23.1770080116678;
        Mon, 02 Feb 2026 16:55:16 -0800 (PST)
X-Received: by 2002:a05:622a:1308:b0:502:a100:4054 with SMTP id d75a77b69052e-505d217d0a4mr175263341cf.23.1770080116324;
        Mon, 02 Feb 2026 16:55:16 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d3740e62sm125467246d6.26.2026.02.02.16.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 16:55:15 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3119bafd-5cdc-4f0a-86df-d245a43aef1b@redhat.com>
Date: Mon, 2 Feb 2026 19:55:14 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v3 2/3] cgroup/cpuset: Defer
 housekeeping_update() calls from CPU hotplug to workqueue
To: Peter Zijlstra <peterz@infradead.org>, Waiman Long <llong@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260202201144.1669260-1-longman@redhat.com>
 <20260202201144.1669260-3-longman@redhat.com>
 <20260202201844.GJ1395266@noisy.programming.kicks-ass.net>
 <a503d890-0c83-4741-b622-88798016787c@redhat.com>
 <20260202204806.GL1395266@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20260202204806.GL1395266@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-13617-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DAB8D32C0
X-Rspamd-Action: no action

On 2/2/26 3:48 PM, Peter Zijlstra wrote:
> On Mon, Feb 02, 2026 at 03:32:03PM -0500, Waiman Long wrote:
>> On 2/2/26 3:18 PM, Peter Zijlstra wrote:
>>> On Mon, Feb 02, 2026 at 03:11:43PM -0500, Waiman Long wrote:
>>>
>>>> @@ -1310,14 +1321,34 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>>>>     */
>>>>    static void update_isolation_cpumasks(void)
>>>>    {
>>>> -	int ret;
>>>> +	static DECLARE_WORK(isolcpus_work, isolcpus_workfn);
>>>>    	if (!isolated_cpus_updating)
>>>>    		return;
>>>> -	ret = housekeeping_update(isolated_cpus);
>>>> -	WARN_ON_ONCE(ret < 0);
>>>> +	/*
>>>> +	 * This function can be reached either directly from regular cpuset
>>>> +	 * control file write or via CPU hotplug. In the latter case, it is
>>>> +	 * the per-cpu kthread that calls cpuset_handle_hotplug() on behalf
>>>> +	 * of the task that initiates CPU shutdown or bringup.
>>>> +	 *
>>>> +	 * To have better flexibility and prevent the possibility of deadlock
>>>> +	 * when calling from CPU hotplug, we defer the housekeeping_update()
>>>> +	 * call to after the current cpuset critical section has finished.
>>>> +	 * This is done via workqueue.
>>>> +	 */
>>>> +	if (current->flags & PF_KTHREAD) {
>>> 		/* Serializes the static isolcpus_workfn. */
>>> 		lockdep_assert_held(&cpuset_mutex);
>> Do we require synchronization between the the queue_work() call and the
>> execution of the work function? I thought it is not needed, but I may be
>> wrong.
> Well, something needs to ensure there aren't two threads trying to use
> this one work thing at the same time, no?

isolcpus_workfn() does touches the work struct and there can't be more 
than one thread calling queue_work() with the same work. However it is 
possible that if isolcpus_workfn() and this code path are completely 
async, there is a chance that we may miss a call to 
housekeeping_update(). So I need to take a further look into that.

Cheers,
Longman


