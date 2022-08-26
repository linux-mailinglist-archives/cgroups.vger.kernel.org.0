Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1B95A2CDA
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 18:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344771AbiHZQxC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Aug 2022 12:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243496AbiHZQxB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Aug 2022 12:53:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74C96156;
        Fri, 26 Aug 2022 09:52:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4E4863369A;
        Fri, 26 Aug 2022 16:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661532778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hvh3ocNfi9tDUDY607bUOsG3YfmuEtYhO6IYXUHPG/Y=;
        b=iZPWN9zbTtAeBhE6GPmrISfKZTKDyRDEBt/NCX6jxUD5aOCumahpiZpRRQZJG5sSstyR9V
        /CxenkC8LBSDzl0Q+lWiZZEEKR1HoAnVbCQkvVBEV8A9g9upAyc090FiUXaE4EB5ZKwDUj
        vA1rDztB+5zLeJtfleOJOBR6UpCuVXE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A8BB13A7E;
        Fri, 26 Aug 2022 16:52:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 99GqAWr6CGMofAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 26 Aug 2022 16:52:58 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Aditya Kali <adityakali@google.com>,
        Serge Hallyn <serge.hallyn@canonical.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        Muneendra Kumar <muneendra.kumar@broadcom.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH 0/4] Honor cgroup namespace when resolving cgroup id
Date:   Fri, 26 Aug 2022 18:52:34 +0200
Message-Id: <20220826165238.30915-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Cgroup id is becoming a new way for userspace how to refer to cgroups it
wants to act upon. As opposed to cgroupfs (paths, opened FDs), the
current approach does not reflect limited view by (non-init) cgroup
namespaces.

This patches don't aim to limit what a user can do (consider an uid=0 in
mere cgroup namespace) but to provide consistent view within a
namespace.

The series is based on bpf-next with the new cgroup_iter. I've only
boot-tested it (especially I didn't run the BPF selftest).

Michal Koutný (4):
  cgroup: Honor caller's cgroup NS when resolving path
  cgroup: cgroup: Honor caller's cgroup NS when resolving cgroup id
  cgroup: Homogenize cgroup_get_from_id() return value
  cgroup/bpf: Honor cgroup NS in cgroup_iter for ancestors

 block/blk-cgroup-fc-appid.c |  4 +--
 include/linux/cgroup.h      |  8 +++---
 kernel/bpf/cgroup_iter.c    |  9 ++++---
 kernel/cgroup/cgroup.c      | 53 ++++++++++++++++++++++++++++---------
 mm/memcontrol.c             |  4 +--
 5 files changed, 54 insertions(+), 24 deletions(-)


base-commit: 343949e10798a52c6d6a14effc962e010ed471ae
-- 
2.37.0

