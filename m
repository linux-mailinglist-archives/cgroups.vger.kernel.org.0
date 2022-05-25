Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A256453402B
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 17:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiEYPPe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 11:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241797AbiEYPP3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 11:15:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADC0B041F;
        Wed, 25 May 2022 08:15:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0DA13219D9;
        Wed, 25 May 2022 15:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653491727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4a7cwmdTvdlgEFSejjSvX4/8ts7XavMCpiK8LNYnCOA=;
        b=S764p8MSC4ECPdB9CovFD1ktd/0hVWDcubdEvvK8aSmY0UJpusRO6HHKQSsTNcMgWuyCql
        eBLZQrbPK0PC1oKOoUneaQ6fM2bdgxjIUAxHIpVWqwEAtMxZnfNueDfxUhaB6+kkOGb1xW
        DRX0/paoMi8hgAvuAuVI1kPl8BHSJv0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6F5413ADF;
        Wed, 25 May 2022 15:15:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oCdFMw5IjmLXAwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 25 May 2022 15:15:26 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>,
        Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: [PATCH 0/2] cgroup_subsys_state lifecycle fixups
Date:   Wed, 25 May 2022 17:15:15 +0200
Message-Id: <20220525151517.8430-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.35.3
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

Two corner cases were hanging around [2][3] related to css lifecycles,
since they're loosely related I'm sending them together.

The 2nd patch fixes problems encountered in syzbot tests only.
Alternative solutions could be:
- daisy-chain css_release_work_fn from the offending css_killed_work_fn call,
- rework kill_css() not to rely on multi-stage css_killed_work_fn() [1].

The simplest approach was chosen.

The other existing users of percpu_ref_kill_and_confirm are not affected by
similar issues.

[1] Rough idea is to only synchronize via a completion like e.g.
nvmet_sq_destroy() does and move most of css_killed_work_fn() at the end of
kill_css(). kill_css() is only used in process context when de-configuring
controllers or rmdiring a cgroup.

[2] https://lore.kernel.org/lkml/20220404142535.145975-1-minhquangbui99@gmail.com/
[3] https://lore.kernel.org/lkml/20220412192459.227740-1-tadeusz.struk@linaro.org/

Michal Koutný (2):
  cgroup: Wait for cgroup_subsys_state offlining on unmount
  cgroup: Use separate work structs on css release path

 include/linux/cgroup-defs.h |  5 +++--
 kernel/cgroup/cgroup.c      | 19 +++++++++++--------
 2 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.35.3

