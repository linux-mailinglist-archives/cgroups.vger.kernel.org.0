Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528FA526820
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 19:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381108AbiEMRSo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 13:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbiEMRSn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 13:18:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D123B28B;
        Fri, 13 May 2022 10:18:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2B6931F949;
        Fri, 13 May 2022 17:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652462320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lUuJK4eL9+OrReBYOWwXyTY//4zqDis40btPse6/uis=;
        b=ZfFAq7QzVD1bjBp+hkF5Z3fIv8AxgN0GzCRe9/I5WP8uaXdZ+RPtceXWSsm6MUZFQnXRSC
        2oKg8kF5CJh4K3Mi+mNb8k/06l/ppvpwpWERxZqevlMKpjNhxXkNBOSwii9lXxf/7qjD+u
        vNfpJWgXzl11DC15sWKmZHQbjp4oyFE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D660013446;
        Fri, 13 May 2022 17:18:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vARDM++SfmIeUgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 13 May 2022 17:18:39 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     void@manifault.com
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, mkoutny@suse.com, roman.gushchin@linux.dev,
        shakeelb@google.com, tj@kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>
Subject: [PATCH 0/4] memcontrol selftests fixups
Date:   Fri, 13 May 2022 19:18:07 +0200
Message-Id: <20220513171811.730-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220512174452.tr34tuh4k5jm6qjs@dev0025.ash9.facebook.com>
References: <20220512174452.tr34tuh4k5jm6qjs@dev0025.ash9.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

I'm just flushing the simple patches to make memcontrol selftests check the
events behavior we had consensus about (test_memcg_low fails). (I've dropped to
goto macros for now.)

(test_memcg_reclaim, test_memcg_swap_max fail for me now but it's present
even before the refactoring.)

The only bigger change is adjustment of the protected values to make tests
succeed with the given tolerance.

It's based on mm-stable [1] commit e240ac52f7da. AFAIC, the fixup and partial
reverts may be folded into respective commits.
Let me know if it should be (re)based on something else.

Thanks,
Michal

[1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/tools/testing/selftests/cgroup?h=mm-stable

Michal Koutný (4):
  selftests: memcg: Fix compilation
  selftests: memcg: Expect no low events in unprotected sibling
  selftests: memcg: Adjust expected reclaim values of protected cgroups
  selftests: memcg: Remove protection from top level memcg

 .../selftests/cgroup/test_memcontrol.c        | 59 +++++++++----------
 1 file changed, 29 insertions(+), 30 deletions(-)

-- 
2.35.3

