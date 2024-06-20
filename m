Return-Path: <cgroups+bounces-3254-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7225910913
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 16:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECDF283659
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 14:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBB51AE87C;
	Thu, 20 Jun 2024 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9oD62H7"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1D21AE083
	for <cgroups@vger.kernel.org>; Thu, 20 Jun 2024 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895296; cv=none; b=ZnhmTjWX8fFLzZpcLFuiXDOoiU9YbYhwcWuVnTf8gygmhJ76fHZGtZ/YiLQm4Pe6K03+cxDrJhBeRniF0Wb/gpvhpIPzMttqBsICh+1AzvOXTkwnN1dnF/T/bvWaqPvVoBhoWJ1MmMowaL8lE+U80V2VigxAQJcAe9pjT1htnYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895296; c=relaxed/simple;
	bh=+mc4hdmKVY2EQaTK2A4CHHL4RF7cnX8tckscxTNdMBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQ3KhQ5ITBN3Dt3BpVp88wteY177EleQKzQIaYNAFcmpr6uihocNeaUvNEbIFKnQW77ggvtONmO3tkZpRtdej46cer6ROtpNOPCZ+lxV0THQw+vG7G/AB9yjtuXBiKlVwiuTE07gCLhdmIoJp9qUKiGebaMyiEIpnIQvT25nAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9oD62H7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718895293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yt6kXaMST49pKLabNO81NG5Y01PoCbKhbgnCP+N4TNw=;
	b=h9oD62H7VXsUFyw8pGHljPyRM82MUjVnqq5cjLkt+NISwoKcoY5CVv/nZ7sZ5vKQfKW1F1
	2fDglW41UB8dS/B554uUxdf1S2I1zaqciKzFN6BO5UWhlJniV3kO4dv24LwHgGQ3c6P8SX
	e0Vdxpehc/EWL0HGqG639ZDlksm21/Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-zsBj2URBMPWOF0QVtMNxLw-1; Thu,
 20 Jun 2024 10:54:50 -0400
X-MC-Unique: zsBj2URBMPWOF0QVtMNxLw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AEA819560BD;
	Thu, 20 Jun 2024 14:54:49 +0000 (UTC)
Received: from [10.22.9.18] (unknown [10.22.9.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5556C19560AE;
	Thu, 20 Jun 2024 14:54:47 +0000 (UTC)
Message-ID: <b511173c-53fe-4a93-8030-d99ed1b65bd6@redhat.com>
Date: Thu, 20 Jun 2024 10:54:46 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 v4 1/2] Union-Find: add a new module in kernel library
To: Xavier <xavier_qy@163.com>, mkoutny@suse.com
Cc: lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240603123101.590760-1-ghostxavier@sina.com>
 <20240620085233.205690-1-xavier_qy@163.com>
 <20240620085233.205690-2-xavier_qy@163.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240620085233.205690-2-xavier_qy@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 6/20/24 04:52, Xavier wrote:
> This patch implements a union-find data structure in the kernel library,
> which includes operations for allocating nodes, freeing nodes,
> finding the root of a node, and merging two nodes.
>
> Signed-off-by: Xavier <xavier_qy@163.com>
> ---
>   MAINTAINERS                |  7 +++++++
>   include/linux/union_find.h | 30 ++++++++++++++++++++++++++++++
>   lib/Makefile               |  2 +-
>   lib/union_find.c           | 38 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 76 insertions(+), 1 deletion(-)
>   create mode 100644 include/linux/union_find.h
>   create mode 100644 lib/union_find.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6c90161c7..602d8c6f42 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23054,6 +23054,13 @@ F:	drivers/cdrom/cdrom.c
>   F:	include/linux/cdrom.h
>   F:	include/uapi/linux/cdrom.h
>   
> +UNION-FIND
> +M:	Xavier <xavier_qy@163.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	include/linux/union_find.h
> +F:	lib/union_find.c
> +
>   UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER
>   R:	Alim Akhtar <alim.akhtar@samsung.com>
>   R:	Avri Altman <avri.altman@wdc.com>
> diff --git a/include/linux/union_find.h b/include/linux/union_find.h
> new file mode 100644
> index 0000000000..67e9f62bb3
> --- /dev/null
> +++ b/include/linux/union_find.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_UNION_FIND_H
> +#define __LINUX_UNION_FIND_H
> +#include <linux/slab.h>
> +
> +/* Define a union-find node struct */
> +struct uf_node {
> +	struct uf_node *parent;
> +	unsigned int rank;
> +};
> +
> +/* Allocate nodes and initialize to 0 */
> +static inline struct uf_node *uf_nodes_alloc(unsigned int node_num)
> +{
> +	return kzalloc(sizeof(struct uf_node) * node_num, GFP_KERNEL);
> +}
> +
> +/* Free nodes*/
> +static inline void uf_nodes_free(struct uf_node *nodes)
> +{
> +	kfree(nodes);
> +}
> +
> +/* find the root of a node*/
> +struct uf_node *uf_find(struct uf_node *node);
> +
> +/* Merge two intersecting nodes */
> +void uf_union(struct uf_node *node1, struct uf_node *node2);
> +
> +#endif /*__LINUX_UNION_FIND_H*/
> diff --git a/lib/Makefile b/lib/Makefile
> index 3b17690456..e1769e6f03 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -34,7 +34,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
>   	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
>   	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
>   	 nmi_backtrace.o win_minmax.o memcat_p.o \
> -	 buildid.o objpool.o
> +	 buildid.o objpool.o union_find.o
>   
>   lib-$(CONFIG_PRINTK) += dump_stack.o
>   lib-$(CONFIG_SMP) += cpumask.o
> diff --git a/lib/union_find.c b/lib/union_find.c
> new file mode 100644
> index 0000000000..2f77bae1ca
> --- /dev/null
> +++ b/lib/union_find.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/union_find.h>

I would suggest that you briefly document what is a union-find algorithm 
and data structure and what is it good for.

Cheers,
Longman

> +
> +struct uf_node *uf_find(struct uf_node *node)
> +{
> +	struct uf_node *parent;
> +
> +	if (!node->parent) {
> +		node->parent = node;
> +		return node;
> +	}
> +
> +	/*Find the root node and perform path compression at the same time*/
> +	while (node->parent != node) {
> +		parent = node->parent;
> +		node->parent = parent->parent;
> +		node = parent;
> +	}
> +	return node;
> +}
> +
> +/*Function to merge two sets, using union by rank*/
> +void uf_union(struct uf_node *node1, struct uf_node *node2)
> +{
> +	struct uf_node *root1 = uf_find(node1);
> +	struct uf_node *root2 = uf_find(node2);
> +
> +	if (root1 != root2) {
> +		if (root1->rank < root2->rank) {
> +			root1->parent = root2;
> +		} else if (root1->rank > root2->rank) {
> +			root2->parent = root1;
> +		} else {
> +			root2->parent = root1;
> +			root1->rank++;
> +		}
> +	}
> +}


