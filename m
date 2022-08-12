Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3438590EFF
	for <lists+cgroups@lfdr.de>; Fri, 12 Aug 2022 12:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbiHLKPu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Aug 2022 06:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238210AbiHLKPY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Aug 2022 06:15:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4F8ABD6E;
        Fri, 12 Aug 2022 03:14:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5DAAF5C9AD;
        Fri, 12 Aug 2022 10:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660299286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZbZXqZhVMx97LH/wfbkAQvfgc1/NDVE/NEBNZNQzYTU=;
        b=GiRwDUFguJx6UvwA2htp1tu/od4+/MgY/Ty7gEBk9JA03HG8yddGZJKVoyZfXc22LFyX/7
        fsAhQ/NV/xEVrOr12UZ9Skp2vUueX3AnUd8NKHbZulNBtlMuqR83lmlBIZ3GzXWqC01Kwo
        Z8akVkNyRUB1+GfFYrb6Yvt6Q8gw02w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F310413305;
        Fri, 12 Aug 2022 10:14:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dYwmOhUo9mJmVQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 12 Aug 2022 10:14:45 +0000
Date:   Fri, 12 Aug 2022 12:14:44 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     hannes@cmpxchg.org, tj@kernel.org, corbet@lwn.net,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH v2 09/10] sched/psi: per-cgroup PSI stats
 disable/re-enable interface
Message-ID: <YvYoFNDMdg6mdFbU@blackbook>
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
 <20220808110341.15799-10-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808110341.15799-10-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Chengming.

On Mon, Aug 08, 2022 at 07:03:40PM +0800, Chengming Zhou <zhouchengming@bytedance.com> wrote:
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index dd84e34bc051..ade40506ab80 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -968,6 +968,13 @@ All cgroup core files are prefixed with "cgroup."
>  	killing cgroups is a process directed operation, i.e. it affects
>  	the whole thread-group.
>  
> +  cgroup.psi
> +	A read-write single value file that allowed values are "0" and "1".
> +	The default is "1".
> +
> +	Writing "0" to the file will disable the cgroup PSI stats accounting.
> +	Writing "1" to the file will re-enable the cgroup PSI stats accounting.
> +

I'd suggest explaining here explicitely, this control attribute is not
hierarchical (i.e. PSI accounting in a cgroup does not affect accounting
in descendants and doesn't need pass enablement via ancestors from
root). And the purpose that it "saves" cycles (where).

Regards,
Michal
