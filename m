Return-Path: <cgroups+bounces-16398-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LSDEH+ZGGr+lQgAu9opvQ
	(envelope-from <cgroups+bounces-16398-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 21:37:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AD55F738F
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 21:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBA82300AC99
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 19:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A573E332629;
	Thu, 28 May 2026 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5nD2zmj"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248D82F1FEA
	for <cgroups@vger.kernel.org>; Thu, 28 May 2026 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997039; cv=none; b=XpZ5rsXeNCDgYJn4V7eNbhAeWa8B7bg9jAfCSAivMmdiMB5c57ZQ8vRy95x9fvdRBXWzZJWqBdCjlv14/A3p58sQvzo930ySjx9rFFBwRntlgnIwnQ5dzFBLp9Ajmu6q7TmhIlqewMdBKKsekzYPdC579WUKPrd8dUvPbDYdLww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997039; c=relaxed/simple;
	bh=TWL9O5l7oE9EvQKGdqVaYuIS0af1DELOp1ekwEGNIJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZCW2ppphOLGjwvJqbmly+rvwyW46hPl8f/v1A4N9kCks36h/Y7YEfI4cl2BVbe/iU494pQhz7E5Czi7VM+be3EAxKrSECvTYb3ahFBMImL6b1t0PqhCFK+cjAF3AnmlXDVNjdIORo+OCd2v/Dw2EN5OhtogApq/11aCy6Qqp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5nD2zmj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779997037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/Y06T/cRIeYfrCeql2lWHIoraymE8skfKnjtZVSJkU=;
	b=V5nD2zmj51k3OdQo2+OxNJO9XfOLCpmdKSTvGDCqp6CwFtmqpacxc/Z3mT/HOZ+laMp1uR
	iWzv2t9wGszjb3A41QHClFb5bVkwSRwDDN68KNgJOrdRmG3XIe5gETH/Wz07JgtC+/iWdw
	HRZVazWF5Zeh0Ku3OVS35qKMjIFTgaY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-9RtqLVQAPB-CYuUB4EPXcg-1; Thu,
 28 May 2026 15:37:11 -0400
X-MC-Unique: 9RtqLVQAPB-CYuUB4EPXcg-1
X-Mimecast-MFC-AGG-ID: 9RtqLVQAPB-CYuUB4EPXcg_1779997029
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1790B195609F;
	Thu, 28 May 2026 19:37:08 +0000 (UTC)
Received: from [10.22.65.204] (unknown [10.22.65.204])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D0A071955F22;
	Thu, 28 May 2026 19:37:04 +0000 (UTC)
Message-ID: <305848e7-f987-494c-8244-bcf8eed6fb7d@redhat.com>
Date: Thu, 28 May 2026 15:37:04 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: don't allow empty relative nodemask in
 mpol_relative_nodemask()
To: Yury Norov <ynorov@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Farhad Alemi <farhad.alemi@berkeley.edu>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, cgroups@vger.kernel.org
References: <20260528190337.878027-1-ynorov@nvidia.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260528190337.878027-1-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16398-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,linux-foundation.org,kernel.org,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,kvack.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D2AD55F738F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 3:03 PM, Yury Norov wrote:
> Reassigning nodes relative an empty user-provided nodemask is useless,
> and triggers divide-by-zero in the function.
>
> Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
> Link: https://lore.kernel.org/all/CA+0ovCgxbZkXa+OU8w3s84R3KNPNxxRfmsNR-udh+afQBbGNmw@mail.gmail.com/
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>   mm/mempolicy.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 4e4421b22b59..cd961fa1eb33 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -370,8 +370,13 @@ static inline int mpol_store_user_nodemask(const struct mempolicy *pol)
>   static void mpol_relative_nodemask(nodemask_t *ret, const nodemask_t *orig,
>   				   const nodemask_t *rel)
>   {
> +	unsigned int w = nodes_weight(*rel);
>   	nodemask_t tmp;
> -	nodes_fold(tmp, *orig, nodes_weight(*rel));
> +
> +	if (w == 0)
> +		return -EINVAL;
> +
> +	nodes_fold(tmp, *orig, w);
>   	nodes_onto(*ret, tmp, *rel);
>   }
>   

mpol_relative_nodemask() is a void function, so this code should fail 
compilation. Right?

Cheers,
Longman


