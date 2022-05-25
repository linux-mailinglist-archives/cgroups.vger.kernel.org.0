Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453FC5346D2
	for <lists+cgroups@lfdr.de>; Thu, 26 May 2022 00:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244577AbiEYWvz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 18:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiEYWvy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 18:51:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF492409F;
        Wed, 25 May 2022 15:51:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B5CB31F91C;
        Wed, 25 May 2022 22:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653519112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QP07LDyVTEoT20uTedwg+UGDjLkX645oy3+oI/k9KRs=;
        b=Un5rEjXdkXJRg/7BDQ4WUW/5PsCCqQ5kj5pJaQp7Co5y558JEvVWkwTggBiPxw9IsU/Jgz
        VkB5iahLfTOZjyEDs8pggBJHpKHHjfSOlosX/O9wN7Tobvg5sArOIb3hJ9uVgCoKf2SLP6
        rx7GDfcaa0DgZ9PwdWMgZNWZGf5fT90=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7EB2813487;
        Wed, 25 May 2022 22:51:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p/zbHAizjmLuLgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 25 May 2022 22:51:52 +0000
Date:   Thu, 26 May 2022 00:51:46 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     shisiyuan19870131@gmail.com
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Return if dst_cgrp equals to src_cgrp
Message-ID: <Yo6zAi+Y/uXLYUI7@blackbook>
References: <1653066120-21262-1-git-send-email-shisiyuan@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653066120-21262-1-git-send-email-shisiyuan@xiaomi.com>
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

On Sat, May 21, 2022 at 01:02:00AM +0800, shisiyuan <shisiyuan19870131@gmail.com> wrote:
> In function cgroup_migrate_add_src(), if dst_cgrp
> equals to src_cgroup which the tasks link, dont
> go on migrating tasks to another css_set.

Do you have an example which operations lead to this situation?

> This can save the cost of unnecessary migration.

How much are the savings visible?

(Note, I suspect the shortcut on `src_cgrp == dst_cgrp` might not be
always correct when called from cgroup_update_dfl_csses() but not 100%
sure now.)

Thanks,
Michal
