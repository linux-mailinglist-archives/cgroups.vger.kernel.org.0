Return-Path: <cgroups+bounces-13613-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEDQJfsJgWkCDwMAu9opvQ
	(envelope-from <cgroups+bounces-13613-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 21:32:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15036D11C4
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 21:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9415D303E748
	for <lists+cgroups@lfdr.de>; Mon,  2 Feb 2026 20:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229012C08AB;
	Mon,  2 Feb 2026 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuggGv1b";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZu33w+4"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635932C0271
	for <cgroups@vger.kernel.org>; Mon,  2 Feb 2026 20:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064367; cv=none; b=ipmgwUIxyKDINj7lNj+XgwebXFN25gFl8vESU0HSzqxry/HDWqT4TRGsrj1HnQlEgmv+o2ooyyg8uJ09djGwwk0KHC+cs0BpaVcfG9Wcfq53JS0jnfAyvWxmzY6+FD8jLizOqgK4mStYf5B+ty2/mng2bWuhd/CoQZ1GBPbT7LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064367; c=relaxed/simple;
	bh=bLSXIEyqATMhnbXgJDjHNJpKuxrFMC8eHMTi1SFlvBE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PzW78DW9jEs18f5DR4PqNWq7MEvdk9+uDK+BNMWvWf1XPGkkhSwkamUgC2NaX+ceJz7Rz802PCVJ5HtUE8i140AxQKDlU07n3v7Ric8oOa5jBk2GF+e7Z7gNXD+1QSxFg/QSZ8X6GrT098Wb8XLEiGLrObz/iDywZRn2Qv/LoaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iuggGv1b; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZu33w+4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770064327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5gJYhxcAhJt/c1o8miiRcgCbdII4JGSN+/YgCren9w=;
	b=iuggGv1bHPkOGlRel1lhwT5V9QiyNusn8oaHmSfqWaKVi/qFRAsjKSaR97t+65VCyj/e5h
	AngEBczWzT+SxvyAziTxMW30ANKwXesue42Oq+AHVSq/UiAX8miAnnwyW+6ZQ4MNaTuqUC
	/LYrGatOkLf0SZj9FtX5AVJcW4kMt2A=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-DGA9aWeyN4-H59U5Voq0LA-1; Mon, 02 Feb 2026 15:32:05 -0500
X-MC-Unique: DGA9aWeyN4-H59U5Voq0LA-1
X-Mimecast-MFC-AGG-ID: DGA9aWeyN4-H59U5Voq0LA_1770064325
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-502a4aca949so246394821cf.2
        for <cgroups@vger.kernel.org>; Mon, 02 Feb 2026 12:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770064325; x=1770669125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q5gJYhxcAhJt/c1o8miiRcgCbdII4JGSN+/YgCren9w=;
        b=iZu33w+4xgflLk4Tt7YMJSCINvf7U6M+5luNmZY5G3jONKv2UESHXZseOXLu7k3B3S
         p8jy3+wo6Kow08VYwQW/L84qt5O7kCswrj2PTHXX7q6lYTmiEnuUnwclVf4wrnRdcCug
         J1iq7RBUhLNSLfm0ppDh5/hHX/qsBq5PuaPxRrFvjMtW/2D54p+xDB2LvqDW7rDJhwGV
         i8ot8EX829GuOY1uwj/BmRffjnxyulEppTHv7qys6Jx6MN6K+OOz1XIxs8ZFpdYW4KKk
         s2z+794iEg02TL0jgfjc0tTSm0F9sEaWErIRErvQ4/6j3Ko6fa/8hE8CMWWn4EsXNSiq
         q3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770064325; x=1770669125;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5gJYhxcAhJt/c1o8miiRcgCbdII4JGSN+/YgCren9w=;
        b=BWm4y7k31X/jhMp4Z23ROluUpoJwRF93QKlwlPd2L/NE+iM/T0J16VGxHdDh8hY5Cf
         qs+VqGcfMviTTcRaAP4Ggl5qutuka5qyj2rnmUA/xOOYHj4xJ5teM0qsTNrhAZJnL9nC
         zIGHIrx0vGW05TVGovoguxoKGln68FZmD+RU890Jhcpi59TowMXxxfR36IOhXa0o1iIr
         3iLNccsaXam0PH93v/s1mm2FmnHkKNGP1VJdq3Q6eky7t4DJE/Lhg0R91afCrdrV+eOL
         1TMHd/bXctlIKHyC2zvIxvubMtWQSpRC7YZuusMeJWPbEv6RoJOmD6j+gWo5pGZewLRR
         8MQg==
X-Forwarded-Encrypted: i=1; AJvYcCXC3tL10jfqNC7vPhV3YsVY5K9ZCcs1rp7Otdq6rfBwDrP31QRUPK/2dazpXWefT/poDjX3y4QL@vger.kernel.org
X-Gm-Message-State: AOJu0YwJdtGxrvtbzPnIZ3y4meZw9Aqn7RgMrxCd+RUEmeAyQBirsIB2
	p55YnFIxaRz/t2FauxJbNvFeces9Xmu3/mpgWz0HU0AcLtff+C9PpaU4XZXi5ngHtZ+ERbF1anf
	Muu8IPDYWqAQP0Z9bv/gHUnB2pH8ksz0wKzN3DDAvFAD5J161tfPqb1tUG3g=
X-Gm-Gg: AZuq6aIHfWPZiGvzRURDrXa7yMZ976Gqzvi3wzjazCGA+h++Jq2PUNxK8YWnV7GCLkM
	Ud70HDtOX6QNRjWcyscjE/rXamjhvFxG9kqV5jYinovnBYQcRFk4V+YjurmzvAAEcibYXtmUBY6
	o0g1bsc0l0apExDcYiA69MmLtAbNnwMbiWoCtLwQBypEf3y45B0FYX4vA08eR2sP3GufpxB2eMz
	x/YD1pguixKYS4cughI3VvRG3vj1kbMyI1nZVEoro86RFMc5tzRbIcTfAEwps1HIQpgFbmABk0K
	ycdZZuXPYDtUZSKTFcUteXbWRTmvYh3CAeuwJ7CM+9H4+pgUGXOnUVIIZEzQj4FuwguzPYJ5BDK
	+OogvmjxyoHVhTT1HUTj3AqxN3Px+tuteqPY7iHvv6aFyXD6gh34v81tB
X-Received: by 2002:a05:622a:d0:b0:4f7:a0da:ab0c with SMTP id d75a77b69052e-505d21c8451mr169362611cf.28.1770064325435;
        Mon, 02 Feb 2026 12:32:05 -0800 (PST)
X-Received: by 2002:a05:622a:d0:b0:4f7:a0da:ab0c with SMTP id d75a77b69052e-505d21c8451mr169362141cf.28.1770064324960;
        Mon, 02 Feb 2026 12:32:04 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337bbbf8csm114527921cf.28.2026.02.02.12.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 12:32:04 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a503d890-0c83-4741-b622-88798016787c@redhat.com>
Date: Mon, 2 Feb 2026 15:32:03 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v3 2/3] cgroup/cpuset: Defer
 housekeeping_update() calls from CPU hotplug to workqueue
To: Peter Zijlstra <peterz@infradead.org>
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
Content-Language: en-US
In-Reply-To: <20260202201844.GJ1395266@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-13613-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15036D11C4
X-Rspamd-Action: no action

On 2/2/26 3:18 PM, Peter Zijlstra wrote:
> On Mon, Feb 02, 2026 at 03:11:43PM -0500, Waiman Long wrote:
>
>> @@ -1310,14 +1321,34 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>>    */
>>   static void update_isolation_cpumasks(void)
>>   {
>> -	int ret;
>> +	static DECLARE_WORK(isolcpus_work, isolcpus_workfn);
>>   
>>   	if (!isolated_cpus_updating)
>>   		return;
>>   
>> -	ret = housekeeping_update(isolated_cpus);
>> -	WARN_ON_ONCE(ret < 0);
>> +	/*
>> +	 * This function can be reached either directly from regular cpuset
>> +	 * control file write or via CPU hotplug. In the latter case, it is
>> +	 * the per-cpu kthread that calls cpuset_handle_hotplug() on behalf
>> +	 * of the task that initiates CPU shutdown or bringup.
>> +	 *
>> +	 * To have better flexibility and prevent the possibility of deadlock
>> +	 * when calling from CPU hotplug, we defer the housekeeping_update()
>> +	 * call to after the current cpuset critical section has finished.
>> +	 * This is done via workqueue.
>> +	 */
>> +	if (current->flags & PF_KTHREAD) {
> 		/* Serializes the static isolcpus_workfn. */
> 		lockdep_assert_held(&cpuset_mutex);

Do we require synchronization between the the queue_work() call and the 
execution of the work function? I thought it is not needed, but I may be 
wrong.

Thanks,
Longman


