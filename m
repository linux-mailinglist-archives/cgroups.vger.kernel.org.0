Return-Path: <cgroups+bounces-16362-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFdlOs40F2qO9AcAu9opvQ
	(envelope-from <cgroups+bounces-16362-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 20:15:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 477095E8D4F
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 20:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49610309239F
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 18:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D8D3DD87E;
	Wed, 27 May 2026 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/CsWIjO"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E09B26FA5A
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905313; cv=none; b=Pk38tJ7kZJbJJAO7YnITM4hbtbiEzjlAHEtSpPpAryO6SjVwTk5BaFAEPAVbXa2LyPK7XB2Y9TbaWKDqs/b1qjN4BVoRM0cn1PTH36gXTupXxEocbl04/W/oXdUOEY9kIOEeWnJq7sH2iAkUMY1ls0nykn0ip3VtuBOBGz04iuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905313; c=relaxed/simple;
	bh=GtyaSp5Y+ds83ODyqjs2n+z6purm3AZE14zVAYgP2z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTV/oeGw2JBEoQ+XMKFl3PTOXE7GxxpPBtI6492da6BHyXO2r9YTVcvi4B4c5lzhjSsgIuhOEHI7dc5YQueLaeAA09LB8hptmC99Oot14TZ89VRQvSp62W+m+H8RehOV0hV46kxHm10niCBXJ3yhTqhCKnCrzHYZs/Bra+DcqG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E/CsWIjO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779905311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Fgd+efNwqntOKX5XsyATvXQpChpjwSIW92ST2XHIBk=;
	b=E/CsWIjOeSIZZ14srCq+8892fE8024ex+LWsAWBt+1lkhiSJN4e+ZCs1sJSTa5LlYmFU5E
	Qy0IdwaqAs8wAdXixci8Z8asPF9MSvBA81887iMNaVtrUyv7yYjW1Q2SrcebCjGJFCncIl
	qNpP7p0tK5m7p37Rgd8xh46jyrH3aDs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-NNVpxq7yMQiktciWluSaIQ-1; Wed,
 27 May 2026 14:08:25 -0400
X-MC-Unique: NNVpxq7yMQiktciWluSaIQ-1
X-Mimecast-MFC-AGG-ID: NNVpxq7yMQiktciWluSaIQ_1779905304
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B134A1956094;
	Wed, 27 May 2026 18:08:23 +0000 (UTC)
Received: from [10.22.81.53] (unknown [10.22.81.53])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C6ED830002DC;
	Wed, 27 May 2026 18:08:21 +0000 (UTC)
Message-ID: <5289760b-a2a7-4043-962f-49582ddc40ed@redhat.com>
Date: Wed, 27 May 2026 14:08:20 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cgroup/cpuset: Add test cases for sibling CPU
 exclusion on partition update
To: Sun Shaojie <sunshaojie@kylinos.cn>,
 Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhangguopeng@kylinos.cn
References: <20260527064329.640060-2-sunshaojie@kylinos.cn>
 <20260527070509.648304-1-sunshaojie@kylinos.cn>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260527070509.648304-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16362-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Queue-Id: 477095E8D4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 3:05 AM, Sun Shaojie wrote:
> When sibling CPU exclusion occurs, a partition's effective_xcpus may be
> a subset of its user_xcpus. The partcmd_update path must use
> effective_xcpus instead of user_xcpus when calculating CPUs to return
> to or request from the parent.
>
> Add two test cases to verify this behavior:
>
>    1) Narrowing cpuset.cpus to only the sibling-excluded CPUs should not
>       return CPUs to parent that the partition never actually owned.
>
>    2) Expanding cpuset.cpus after a sibling becomes a member should
>       correctly request the additional CPUs from parent.
>
> Co-developed-by: Zhang Guopeng <zhangguopeng@kylinos.cn>
> Signed-off-by: Zhang Guopeng <zhangguopeng@kylinos.cn>
> Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>
> ---
>   tools/testing/selftests/cgroup/test_cpuset_prs.sh | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> index a56f4153c64d..683b05062810 100755
> --- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> +++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> @@ -492,6 +492,16 @@ REMOTE_TEST_MATRIX=(
>   	"  C1-5:P1   .  C1-4:P1   C2-3     .       .  \
>   	      .      .     .       P1      .       .     p1:5|c11:1-4|c12:5 \
>   							 p1:P1|c11:P1|c12:P-1"
> +	# Narrowing cpuset.cpus to previously sibling-excluded CPUs should
> +	# not return CPUs that were never actually owned.
> +	"  C1-4:P1   .   C1-2:P1  C1-3:P2  .       .  \
> +	      .      .     .         C3    .       .     p1:4|c11:1-2|c12:3 \
> +							 p1:P1|c11:P1|c12:P2 3"
> +	# Expanding cpuset.cpus to include a previously sibling-excluded CPU
> +	# after the sibling has become a member should correctly request it.
> +	"  C1-4:P1   .   C1-2:P1  C1-3:P2  .       .  \
> +	      .      .      P0     C2-3    .       .     p1:1,4|c11:1|c12:2-3 \
> +							 p1:P1|c11:P0|c12:P2 2-3"
>   )
>   
>   #
Reviewed-by: Waiman Long <longman@redhat.com>


