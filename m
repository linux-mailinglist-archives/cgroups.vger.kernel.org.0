Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA48D785EE8
	for <lists+cgroups@lfdr.de>; Wed, 23 Aug 2023 19:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbjHWRsK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Aug 2023 13:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjHWRsK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Aug 2023 13:48:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6042E7E;
        Wed, 23 Aug 2023 10:48:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 66445209C6;
        Wed, 23 Aug 2023 17:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692812887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SsaEssAOEkN2Y0295dMCvJoKexgUN6Qg1vqOmf8AW9E=;
        b=AYslP+2cUEdTAAh558fjOTemjSuurI/WV8WG523wzIy5VERo0FA0FclgkKAVPFWTVjdJoG
        me8WfQKcBFgJdermRJCdAAm6fhI5LZQ9vc5oMLfWbEka9q4fyqGOftlRBiPrSJweIDDK1R
        pO4CQztxUV8cHlnyK1JUW+4D3UTIyhU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3ACA513458;
        Wed, 23 Aug 2023 17:48:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Bw1qDVdG5mQ/ZwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 23 Aug 2023 17:48:07 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Firo Yang <firo.yang@suse.com>
Subject: [PATCH 0/2] cgroup: Remove pidlist caching from v1 code
Date:   Wed, 23 Aug 2023 19:48:02 +0200
Message-ID: <20230823174804.23632-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

More details in the first commit message.

Michal Koutný (2):
  cgroup: Print v1 cgroup.procs and tasks without pidlists
  cgroup: Remove v1 specific pidlist code

 include/linux/cgroup-defs.h     |   7 -
 kernel/cgroup/cgroup-internal.h |  12 +-
 kernel/cgroup/cgroup-v1.c       | 384 ++------------------------------
 kernel/cgroup/cgroup.c          |  11 +-
 4 files changed, 26 insertions(+), 388 deletions(-)

-- 
2.41.0

