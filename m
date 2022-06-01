Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DAB53ABFE
	for <lists+cgroups@lfdr.de>; Wed,  1 Jun 2022 19:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356375AbiFARem (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 13:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354976AbiFARei (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 13:34:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605FD8B095;
        Wed,  1 Jun 2022 10:34:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C2FC41F8F6;
        Wed,  1 Jun 2022 17:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654104875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yPxZyhx2htcqKKisRfas+7IPl/BgzIKaMSj2ZzajJIg=;
        b=Zb2LaSt9f1Tc76mutvDU037fDI5D321olqGbDaNXnmynn+N2s6atIKSkK5Y2IX9UxSE2Xj
        1xKdHDQHvzWDIBFqgn0YeqVhdD0GzVvG+BaTKCOSscjDcYv+6zWjtFhum+K2+kA6Dx5v7N
        8q+6TE1IKVeTz+g8OKmulMU9YQaPyVg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87E381330F;
        Wed,  1 Jun 2022 17:34:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lWQnICujl2LiaQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 01 Jun 2022 17:34:35 +0000
Date:   Wed, 1 Jun 2022 19:34:34 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v5 03/11] mm: memcontrol: prepare objcg API for non-kmem
 usage
Message-ID: <20220601173434.GB16134@blackbody.suse.cz>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
 <20220530074919.46352-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220530074919.46352-4-songmuchun@bytedance.com>
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

Hello.

On Mon, May 30, 2022 at 03:49:11PM +0800, Muchun Song <songmuchun@bytedance.com> wrote:
> So we also allocate an object cgroup for the root_mem_cgroup.

This change made me wary that this patch also kmem charging in the
root_mem_cgroup. Fortunately, get_obj_cgroup_from_current won't return
this objcg so all is fine.

> +}
> +#else
> +static inline void obj_cgroup_release_bytes(struct obj_cgroup *objcg)
> +{
> +}
> +#endif

This empty body is for !CONFIG_MEMCG_KMEM, however, the subsequent use for LRU
pages makes no use of these, so it's warranted.

Altogether, I find this correct, hence
Reviewed-by: Michal Koutný <mkoutny@suse.com>
