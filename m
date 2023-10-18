Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21457CDE79
	for <lists+cgroups@lfdr.de>; Wed, 18 Oct 2023 16:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjJROMP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Oct 2023 10:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjJROME (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Oct 2023 10:12:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0DB1B3;
        Wed, 18 Oct 2023 07:11:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9D3811F37E;
        Wed, 18 Oct 2023 14:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697638286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DYiV2GlRsuhLVr+o+u8G875fUeAuZMgyNTvrcWEW7Ls=;
        b=AH7J6bQ4jRhJuFjlD2XOy2YOXaP7CIeRKCUlEbK3rUc+kl3oEbNyJnsFz7SPY3PW3g9Yg7
        ByRaIwmVgsBhmo8lM/kMUVxRR4yuVqr0JLCKlLwCMgBSvHQLSDFrBnC7b009ims80WZaEi
        a5Ej3LHo3l4op7e1KP20IvmvgFASIww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697638286;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DYiV2GlRsuhLVr+o+u8G875fUeAuZMgyNTvrcWEW7Ls=;
        b=WRceSXZYToTwRmBaTbtGNZwl0FvLc1BeLXgZXwIBNHdOOMU2v5Q/Opy7cB6IuZRynBwhNa
        2bo8Ni/IKnUFrYAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71F3F13915;
        Wed, 18 Oct 2023 14:11:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /yosG47nL2XATwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 18 Oct 2023 14:11:26 +0000
Message-ID: <30bf8eb7-f039-48cf-3dca-11f99604e12e@suse.cz>
Date:   Wed, 18 Oct 2023 16:11:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/5] mm: kmem: add direct objcg pointer to task_struct
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, shakeelb@google.com,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20231016221900.4031141-1-roman.gushchin@linux.dev>
 <20231016221900.4031141-3-roman.gushchin@linux.dev>
 <d698b8d0-1697-e336-bccb-592e633e8b98@suse.cz>
In-Reply-To: <d698b8d0-1697-e336-bccb-592e633e8b98@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -4.76
X-Spamd-Result: default: False [-4.76 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-0.66)[82.76%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[11];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/18/23 11:52, Vlastimil Babka wrote:
>> +
>> +	return objcg;
>> +}
>> +
>>  __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
>>  {
>>  	struct mem_cgroup *memcg;
>> @@ -3008,19 +3054,26 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
>>  
>>  	if (in_task()) {
>>  		memcg = current->active_memcg;
>> +		if (unlikely(memcg))
>> +			goto from_memcg;
>>  
>> -		/* Memcg to charge can't be determined. */
>> -		if (likely(!memcg) && (!current->mm || (current->flags & PF_KTHREAD)))
> The checks for current->mm and PF_KTHREAD seem to be gone completely after
> the patch, was that intended and why?

And also they are not present in the new flavor that's current_obj_cgroup().
