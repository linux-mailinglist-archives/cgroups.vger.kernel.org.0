Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE737D07A3
	for <lists+cgroups@lfdr.de>; Fri, 20 Oct 2023 07:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjJTFdj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Oct 2023 01:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjJTFdi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Oct 2023 01:33:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8836A119;
        Thu, 19 Oct 2023 22:33:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0F50D21842;
        Fri, 20 Oct 2023 05:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697780014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PyJ/wzDi6i48iVYJkqxkfxMlKHMIM7+DIbHS1YWntQA=;
        b=FcD3e3il7pO1iMz9Uisi8xhSglA1naMreeVOep+yyOgCE/cf3RW/9ahNz8F0dtYmx+r1op
        yip2TC0SZ/Ep0ogz/M89H9TFl7c6AYi2ktfhT3zqRdbwdnuC4iJXp01YPrVrsoT2rChRjG
        ARk0mCYhxOJYhcuhuvOmWO3KMJiJxEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697780014;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PyJ/wzDi6i48iVYJkqxkfxMlKHMIM7+DIbHS1YWntQA=;
        b=5h+O0a0IBCPO5f430xj/w4BMFK+OzoLtiycyRI5cZLMXlr0zhMNftsRBGLuaPXFzEbEREi
        m5h9XE6FmFS7rwBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB1021348D;
        Fri, 20 Oct 2023 05:33:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VufKNC0RMmXyXgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 20 Oct 2023 05:33:33 +0000
Message-ID: <69ad0c7c-9e34-9eb6-835d-ac40a5023d91@suse.cz>
Date:   Fri, 20 Oct 2023 07:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 2/6] mm: kmem: add direct objcg pointer to task_struct
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20231019225346.1822282-1-roman.gushchin@linux.dev>
 <20231019225346.1822282-3-roman.gushchin@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231019225346.1822282-3-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -8.26
X-Spamd-Result: default: False [-8.26 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-0.16)[69.18%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[11];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/20/23 00:53, Roman Gushchin wrote:
> To charge a freshly allocated kernel object to a memory cgroup, the
> kernel needs to obtain an objcg pointer. Currently it does it
> indirectly by obtaining the memcg pointer first and then calling to
> __get_obj_cgroup_from_memcg().
> 
> Usually tasks spend their entire life belonging to the same object
> cgroup. So it makes sense to save the objcg pointer on task_struct
> directly, so it can be obtained faster. It requires some work on fork,
> exit and cgroup migrate paths, but these paths are way colder.
> 
> To avoid any costly synchronization the following rules are applied:
> 1) A task sets it's objcg pointer itself.
> 
> 2) If a task is being migrated to another cgroup, the least
>    significant bit of the objcg pointer is set atomically.
> 
> 3) On the allocation path the objcg pointer is obtained locklessly
>    using the READ_ONCE() macro and the least significant bit is
>    checked. If it's set, the following procedure is used to update
>    it locklessly:
>        - task->objcg is zeroed using cmpxcg
>        - new objcg pointer is obtained
>        - task->objcg is updated using try_cmpxchg
>        - operation is repeated if try_cmpxcg fails
>    It guarantees that no updates will be lost if task migration
>    is racing against objcg pointer update. It also allows to keep
>    both read and write paths fully lockless.
> 
> Because the task is keeping a reference to the objcg, it can't go away
> while the task is alive.
> 
> This commit doesn't change the way the remote memcg charging works.
> 
> Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Shakeel Butt <shakeelb@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

