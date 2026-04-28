Return-Path: <cgroups+bounces-15538-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGINFi7Q8GnDYwEAu9opvQ
	(envelope-from <cgroups+bounces-15538-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 17:20:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D3D487B41
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 17:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DF2A3047044
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 15:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544ED3B6C08;
	Tue, 28 Apr 2026 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPGybCf5"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CD63B27C9
	for <cgroups@vger.kernel.org>; Tue, 28 Apr 2026 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777389570; cv=none; b=mZniyf+Zj4UXtHBxutNGMzwv0BlJD5AVNF0adO9wHUx8wLSfJpNqZk+9J4eWPGtPnkcIjCrm/DHQfvB8pqIcsLWzjkKiPnZpzB+yGhFp4fau7YmyQuj3IA2dplCL1yHHCHciU/BBp6ygtVfrfqiWpxr0F01ZmvGQLRb11B/tlPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777389570; c=relaxed/simple;
	bh=NZXdk1yBRDOEB3BWO+BVvaayxPjaKo978RfNNBO65Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYzhXIn2j2CZ64JmN4ZleQqfztF+Opzpvygff0D+iTuSl5DCis1oomQTreYaGzR5ifdAZAzuQkNIK7H0/Mnqa5Cf8hI3BJ1I3YVp4h2SvrMn1Nr+/tNfpNQXO04rBS2KuSStgNiYMYK333aolmv8lByZQnTcdYVbZrss91KEk0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPGybCf5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777389566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HDcbwl6sFTXgDrI+UlBZckd1iaxQQF55if0ty09TCYY=;
	b=SPGybCf5F8fLaAWKoXRy/TSMc1sqw748Fu7a7LWi3Up45665xEG3AWmKsEsXCaHYun8tvL
	tGrnku8hKsTP++33N3MXvF3J7ccAu21rGgyq2YhuBu6kFZYTNR3YyDnr92MjqbF8YoReww
	T6vjT51fkBocB5+25rDXGh8eThm0sLk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-vMuwL-NMN4yZc68m8CBAFA-1; Tue,
 28 Apr 2026 11:19:21 -0400
X-MC-Unique: vMuwL-NMN4yZc68m8CBAFA-1
X-Mimecast-MFC-AGG-ID: vMuwL-NMN4yZc68m8CBAFA_1777389559
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA75419560AA;
	Tue, 28 Apr 2026 15:19:18 +0000 (UTC)
Received: from [10.22.65.177] (unknown [10.22.65.177])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B629300756E;
	Tue, 28 Apr 2026 15:19:16 +0000 (UTC)
Message-ID: <9df75f61-0cbb-42b4-b64d-8e6fd49d50ca@redhat.com>
Date: Tue, 28 Apr 2026 11:19:16 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Creating or adding CPUs to partition not
 allowed without privilege
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Chen Ridong <chenridong@huawei.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Xie Maoyi <maoyi.xie@ntu.edu.sg>
References: <20260428033439.783246-1-longman@redhat.com>
 <7so4b76wg2apwwk3yh76q42jgwnpvlv7sursmsmzeyefhp4pbt@thybpp4litm6>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <7so4b76wg2apwwk3yh76q42jgwnpvlv7sursmsmzeyefhp4pbt@thybpp4litm6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: E0D3D487B41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15538-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/28/26 3:58 AM, Michal Koutný wrote:
> Hi Waiman.
>
> On Mon, Apr 27, 2026 at 11:34:39PM -0400, Waiman Long <longman@redhat.com> wrote:
>> Creation of a cpuset partition or adding more CPUs to an existing
>> partition will take CPUs away from other cpusets outside of the
>> partition leaving less CPUs for the others. So it is a privileged
>> operation that non-privileged users shouldn't be allowed to do.
>>
>> Currently, remote partition code has check for CAP_SYS_ADMIN capability
>> before allowing such operations, but not for local partition.
> Remote partitions need such a check because their CPUs are sourced from
> the global supply (top level) without
>
>> This leaves a security hole in case cpuset.cpus.partition of a cpuset
>> is chown'ed to a non-root user and its parent cpuset happens to be a
>> partition root.
> I wouldn't say this difference between remote and local partitions is a
> security hole [1].
OK, I will tone down the description.
>
> Consider this -- cgroup a is created by root (admin) and its resources
> are constrained by root's policy. However, what happens in a subtree is
> irrelevant from that top level view.
>
> # setup			// owner
> a/cpuset.partition=root	// root
> a/cpuset.cpus=0-3	// root
> a/cgroup.procs		// user, they can organize subtree as needed
>
> For example the user may want to create a (sub)partition with some of
> the CPUs they got:
>
> user$ mkdir a/b
>
> a/b/cpuset.partition=root	// user
> a/b/cpuset.cpus=0-1		// user
>
> This should be a valid configuration and behavior, no?

Thank for the comment. Yes, that can be a valid configuration.

One possible workaround may be to see if the current user has write 
access to its parent partition root. If so, we can allow it to create a 
sub-partition, if not, we will forbid it.

Cheers,
Longman


