Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FC952D28E
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 14:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiESMd7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 08:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiESMd4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 08:33:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D017A5A8E;
        Thu, 19 May 2022 05:33:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0A1F621B80;
        Thu, 19 May 2022 12:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652963635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DUkWJZld5VluRI22uW9l8XCJNukHzEbwh8pHQV1m64o=;
        b=ilFTuOmSs8usXtJOYAHg0dTo3pKq3irYc+DYgWtk7Ec18he1Qz+Vf2mp8P9oJTyqCCQA4V
        0Q4FGLqAVvemfhBkAC9PgK4oH/uN/S+Y7ML4mQQZyiy6t10biz5l55zL6atKB/Fk4m7O5X
        uZ35ZbFFrxrV4Asfjf6W4T6pVw3I8Lo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0FCB13456;
        Thu, 19 May 2022 12:33:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a68NMjI5hmJzCwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 19 May 2022 12:33:54 +0000
Date:   Thu, 19 May 2022 14:33:53 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Shida Zhang <starzhangzsd@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        zhangshida@kylinos.cn, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v2] cgroup: remove the superfluous judgment
Message-ID: <20220519123353.GF16096@blackbody.suse.cz>
References: <20220518013647.1749568-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220518013647.1749568-1-zhangshida@kylinos.cn>
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

On Wed, May 18, 2022 at 09:36:47AM +0800, Shida Zhang <starzhangzsd@gmail.com> wrote:
>  kernel/cgroup/cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Michal Koutný <mkoutny@suse.com>

(Note to self, css_clear_dir() on root cgroup is not needed thanks to
kernfs_destroy_root()->kernfs_remove().)
