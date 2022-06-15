Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C80054C4E6
	for <lists+cgroups@lfdr.de>; Wed, 15 Jun 2022 11:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346458AbiFOJlw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Jun 2022 05:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346319AbiFOJlv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Jun 2022 05:41:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484833ED3A;
        Wed, 15 Jun 2022 02:41:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D149F1F984;
        Wed, 15 Jun 2022 09:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655286108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6f7LmKgyp4C8f+DMh1UfRQSRSKDECQlQXNjM/3tlkyo=;
        b=rPB+1CRTKgd1xPx+KfMeX7FH++oXL054wTxWh/VeuqEnfRgUvdFyCoe1i9QT9dZHb7dN6+
        SEfh9+QHmzs6BFs0HZFap5dhkOAXUqM/Ow7idrU6Y7xzs5Hd7xFvHEWCN+1HyzTxHbrLPF
        8eDixoxZXMqwKeUHQaWnpB6468MAj8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655286108;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6f7LmKgyp4C8f+DMh1UfRQSRSKDECQlQXNjM/3tlkyo=;
        b=ZSz1y2A0+YrDzowCa3edbEWx/AQMWCa3u9CIIgE0Er5JfKqm+Hk5k6lZYIMcbnYtrImkfG
        ebyR0VSchAMrRNDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88596139F3;
        Wed, 15 Jun 2022 09:41:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CLd7IFypqWIFRQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 15 Jun 2022 09:41:48 +0000
Message-ID: <9a4a9afe-bbe1-4cb3-713b-f1e4e6d2a049@suse.cz>
Date:   Wed, 15 Jun 2022 11:41:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH mm v6] mm/tracing: add 'accounted' entry into output of
 allocation tracepoints
Content-Language: en-US
To:     Vasily Averin <vvs@openvz.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, cgroups@vger.kernel.org
References: <c1676616-1405-5bcb-af02-c1e9cc83dace@openvz.org>
 <c418ed25-65fe-f623-fbf8-1676528859ed@openvz.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <c418ed25-65fe-f623-fbf8-1676528859ed@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/3/22 05:21, Vasily Averin wrote:
> Slab caches marked with SLAB_ACCOUNT force accounting for every
> allocation from this cache even if __GFP_ACCOUNT flag is not passed.
> Unfortunately, at the moment this flag is not visible in ftrace output,
> and this makes it difficult to analyze the accounted allocations.
> 
> This patch adds boolean "accounted" entry into trace output,
> and set it to 'true' for calls used __GFP_ACCOUNT flag and
> for allocations from caches marked with SLAB_ACCOUNT.
> Set it to 'false' if accounting is disabled in configs.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks, added to slab/for-5.20/tracing

> 
> ---
> v6:
>  1) subject changed from "tracing:" to "mm/tracing:"
>  2) set flag to 'false' if accounting is disabled in configs

Looks like you forgot the kmem_alloc_node variant, fixed up locally:

--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -94,8 +94,9 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
                __entry->bytes_alloc    = bytes_alloc;
                __entry->gfp_flags      = (__force unsigned long)gfp_flags;
                __entry->node           = node;
-               __entry->accounted      = (gfp_flags & __GFP_ACCOUNT) ||
-                                         (s && s->flags & SLAB_ACCOUNT);
+               __entry->accounted      = IS_ENABLED(CONFIG_MEMCG_KMEM) ?
+                                         ((gfp_flags & __GFP_ACCOUNT) ||
+                                         (s && s->flags & SLAB_ACCOUNT)) : false;
        ),
 
        TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d accounted=%s",
