Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D4453AC04
	for <lists+cgroups@lfdr.de>; Wed,  1 Jun 2022 19:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356354AbiFARes (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 13:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356377AbiFARen (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 13:34:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08838B095;
        Wed,  1 Jun 2022 10:34:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6F1281F8F6;
        Wed,  1 Jun 2022 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654104880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GjM3NNyZi+mdyAAgbPoVYQ4gLBCkOnK/73Cw9/lkEMA=;
        b=fMgAUfgOUjfloaDS4p8wAJAzvluuJQWZvnxiAi6ShSWltsPq3megQImODM+d9HSmLxJwFW
        MPWNEw2VE8jdwfgtsn50e1wTFaVQCwr62zTR8vifW9Q6K6zdvBem445A38lxWHjrF3MLUd
        99BaPGC4eSxt1lgF0sZWfxXLV2fja2o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 357AE1330F;
        Wed,  1 Jun 2022 17:34:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vwgcDDCjl2LpaQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 01 Jun 2022 17:34:40 +0000
Date:   Wed, 1 Jun 2022 19:34:38 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v5 09/11] mm: memcontrol: use obj_cgroup APIs to charge
 the LRU pages
Message-ID: <20220601173438.GC2434@blackbody.suse.cz>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
 <20220530074919.46352-10-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220530074919.46352-10-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Muchun.

On Mon, May 30, 2022 at 03:49:17PM +0800, Muchun Song <songmuchun@bytedance.com> wrote:
> +static inline bool obj_cgroup_is_root(struct obj_cgroup *objcg)
> +{
> +	return objcg == root_obj_cgroup;
> +}

Admittedly, this predicate alone caught my eye, why it did not also
check root_mem_cgroup->objcg_list.
However, deeper look reveals it's purpose is to avoid missing uncharges
of pages that were charged in non-root memcg and later re-associated
upwards after reparenting.
So it's like obj_cgroup_root_origin() (I'm not suggesting a rename, just
illustrating the understanding).

get_obj_cgroup_from_current() gains some complexity but it still holds
that in root memcg neither kernel objects nor LRU pages are charged.
At the same time, reparented kernel objects or LRU pages are properly
uncharged.

These parts are 
Reviewed-by: Michal Koutný <mkoutny@suse.com>

(I did not look into the locking guarantees with the new API though.)

