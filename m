Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CDF67DEA8
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 08:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjA0HnW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 02:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjA0HnV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 02:43:21 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C12D39282;
        Thu, 26 Jan 2023 23:43:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 19A1E21D67;
        Fri, 27 Jan 2023 07:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674805399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4JI/wpxgIv1o0sTmnkxzVSGkE+8mTK7sPuU0QG23TKI=;
        b=EqIDPXJijHRpJFC0wlMxMNVbRlqW2RwIS8I1Lqz9jGoxXM7jFvfzghk13Grp77m1uFVnV8
        0KDjgbR+/TI8SY5RIb/Bd2ltnat8wZ7zyvXGhGVSgzg7yZv+ZeDD6CDKa8FAcUSu1euLsj
        JHx9EI5fDMCuR5gvKu+XrvSaFggUC5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674805399;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4JI/wpxgIv1o0sTmnkxzVSGkE+8mTK7sPuU0QG23TKI=;
        b=/twYLq2i4LDG1Ix54DAMhGZf7aVUb/GyfOdsvaMgkiHhWCxxpyHc+eCrPChILIYvin406D
        zv8pa6Mqh0Ai25Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ECDE0138E3;
        Fri, 27 Jan 2023 07:43:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oY3hOJaA02PLZAAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 27 Jan 2023 07:43:18 +0000
Message-ID: <df9c772c-6fb5-1ebe-6b9a-7d052d9f05f0@suse.de>
Date:   Fri, 27 Jan 2023 08:43:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 01/15] blk-cgroup: don't defer blkg_free to a workqueue
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
References: <20230117081257.3089859-1-hch@lst.de>
 <20230117081257.3089859-2-hch@lst.de>
 <b4622942-67e7-969b-4439-0aea7c5bd165@suse.de> <20230127070754.GB4180@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230127070754.GB4180@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/27/23 08:07, Christoph Hellwig wrote:
> On Fri, Jan 27, 2023 at 07:59:23AM +0100, Hannes Reinecke wrote:
>> On 1/17/23 09:12, Christoph Hellwig wrote:
>>> Now that blk_put_queue can be called from process context, ther is no
>>> need for the asynchronous execution.
>>>
>> Can you clarify 'now'?
>> IE point to the commit introducing the change?
> 
> 49e4d04f0486117ac57a97890eb1db6d52bf82b3
> Author: Tejun Heo <tj@kernel.org>
> Date:   Fri Jan 6 10:34:10 2023 -1000
> 
>      block: Drop spurious might_sleep() from blk_put_queue()
> 
Can we please have it in the patch comment?
To clarify that this is a pre-requisite for this patch?

Thanks.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

