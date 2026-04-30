Return-Path: <cgroups+bounces-15569-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK5gEq6z82kL6QEAu9opvQ
	(envelope-from <cgroups+bounces-15569-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 21:55:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A42824A77F0
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 21:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA28330340B9
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 19:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F08382F10;
	Thu, 30 Apr 2026 19:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abthxLOs"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99456382F29
	for <cgroups@vger.kernel.org>; Thu, 30 Apr 2026 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777578909; cv=none; b=HiAlq9CAYleGxeOehOW5qHhrIXUB+1J0SN+zqOgSkk97AanG7Rp7ddSjaKtlJ7bZsXxbFUqn+zNu8mbet0SFTCfJ/YlG2ph1dGKOqonmiS1QJsZlTBKQcCzZso/1XT4xfHImkvfP3S2XahiFdkHl+zTyiTBf3OL2qMQJxPLDDaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777578909; c=relaxed/simple;
	bh=82ndRVMvU5Rm3L4xkqPoIhUvLJsOUbOYTeW/5e1ZQhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mphfoWDVgE+z0PDAU6ENmnwhxBn5J8aLvcdzzy9XkuUbRKPkdoLslmhCzP4skNH448eNtcSN/qqGnctQi8krn5CwR+H/tF1PJBck/vGovWW7lTEsR7T1nyt1aWwPpjukv8ccQXohiRjuT3WMLkY5TrLLnl9r7hSTtGfUeC5hMug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=abthxLOs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777578904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWmrmHXW52+KOjBUKSQQzZ6oTYKJGrDyN5SgtJWF5RU=;
	b=abthxLOsESDJwsrD5OwcM0xxx+LMgCnMphHE/ZoltEQ/S7qn9cSvr4GXTL7sYNjGgzX7L/
	CQP7wRc7BHf0X6Ysf0iJJeFS4CO80gXFqBm6SrrDqWXNPdhpw17SguW5XD/9i1VCCs4Xju
	QgbsJ08NAommpJ6iS+DAsFmTnGYPToU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-9PLioaVwMK2T8J5GbcaGuw-1; Thu,
 30 Apr 2026 15:55:00 -0400
X-MC-Unique: 9PLioaVwMK2T8J5GbcaGuw-1
X-Mimecast-MFC-AGG-ID: 9PLioaVwMK2T8J5GbcaGuw_1777578898
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84BCE1956059;
	Thu, 30 Apr 2026 19:54:58 +0000 (UTC)
Received: from [10.22.65.186] (unknown [10.22.65.186])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5F6030001BE;
	Thu, 30 Apr 2026 19:54:56 +0000 (UTC)
Message-ID: <c2e43724-1f40-4643-a506-16ba43ac8b1a@redhat.com>
Date: Thu, 30 Apr 2026 15:54:55 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset: Clarify the delegation rules of
 partition
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Chen Ridong <chenridong@huawei.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xie Maoyi <maoyi.xie@ntu.edu.sg>
References: <20260428180935.806284-1-longman@redhat.com>
 <h46vz32432zl6xu773hfvnpze5zt7berywvg233esmeiftiruo@aub2kgpwi6zd>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <h46vz32432zl6xu773hfvnpze5zt7berywvg233esmeiftiruo@aub2kgpwi6zd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: A42824A77F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-15569-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+]

On 4/30/26 3:46 PM, Michal Koutný wrote:
> On Tue, Apr 28, 2026 at 02:09:35PM -0400, Waiman Long <longman@redhat.com> wrote:
>> Creation of remote partition is currently not allowed without privilege.
>> On the other hand, creation of local partition is allowed without
>> privilege as long as its parent is also a partition root.
>>
>> The current setup allows a delegator to delegate an exclusive set of
>> CPUs to the delegatee by making the root of a delegated sub-hierarchy
>> a partition root. The delegatee is then allowed to create a local
>> sub-partition underneath it if necessary. Creation of a remote
>> partition is not currently allowed across delegation boundary without
>> privilege. Clarify the partition delegation rules by stating the current
>> behavior in cgroup-v2.rst file.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   Documentation/admin-guide/cgroup-v2.rst | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
> After Tejun pointed out that other generic paragraph:
> | This means that the controller interface files - anything which
> | doesn't start with "cgroup." are owned by the parent rather than the
> | cgroup itself.
>
> I think the extra words may only increase confusion (and constrain
> generic changes). So it was a good exercise but nothing needs to be
> necessarily changed regarding this behaivor or its docs.

That is fine. This doc change is optional and I agree that we may want 
more flexibility in case we change the behavior in the future.

Cheers,
Longman


