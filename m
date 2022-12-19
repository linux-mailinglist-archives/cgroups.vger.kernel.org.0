Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC73B650AD2
	for <lists+cgroups@lfdr.de>; Mon, 19 Dec 2022 12:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiLSLl1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Dec 2022 06:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiLSLlY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Dec 2022 06:41:24 -0500
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16653F52
        for <cgroups@vger.kernel.org>; Mon, 19 Dec 2022 03:41:22 -0800 (PST)
Received: from [192.168.16.45] (helo=fisk.sw.ru)
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <nikolay.borisov@virtuozzo.com>)
        id 1p7EVs-00EvES-HM;
        Mon, 19 Dec 2022 12:40:56 +0100
From:   Nikolay Borisov <nikolay.borisov@virtuozzo.com>
To:     tj@kernel.org
Cc:     cgroups@vger.kernel.org, paul@paul-moore.com, kernel@openvz.org,
        Nikolay Borisov <nikolay.borisov@virtuozzo.com>
Subject: [PATCH 0/2] Defer checking wildcard exceptions to parent
Date:   Mon, 19 Dec 2022 13:40:50 +0200
Message-Id: <20221219114052.1582992-1-nikolay.borisov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patchset enables adding a wildcard exception to a child cgroup irrespective
whether the parent allows it or not. At first sight this might seem like
fundamentally breaking the devcgroup hierarchy invariant that child cgroups can't
be more permissive than their parent, however that's not the case. Instead,
when such a wildcard rule is evaluated upon permission check it's actually
checked in the parent cgroup. For example, assume we have the A/B as 2 parent/child
cgroups. A allows a set of devices, but not wildcard rules, and B wants to
access some of those devices of A but initializes A to have a set of well known
character devices and finally writes "b *:* rmw". Currently this would fail, with
this patch the write will succeed and B would have access to only those devices
that are allowed in A.

The situation I described is how systemd functions, in particular when setting up
a devcg for a service it would first disable all devices, then add a bunch of
well-known characters devices and finally evaluate the respective cgroup-related
directives in the service file, in particular that's how systemd is being run.

Without this series systemd-udevd service ends up in a cgroup whose devices.list
contains:

	c 1:3 rwm
	c 1:5 rwm
	c 1:7 rwm
	c 1:8 rwm
	c 1:9 rwm
	c 5:0 rwm
	c 5:2 rwm
	c 136:* rw

But its .service file also instructs it to add 'b *:* rwm' and 'c *:* rwm'. The
parent cg in turn contains:

	c 128:* rwm
	c 136:* rwm
	c 2:* rwm
	c 3:* rwm
	c 1:3 rwm
	c 1:5 rwm
	c 1:7 rwm
	c 5:0 rwm
	c 5:1 rwm
	c 5:2 rwm
	c 4:* rwm
	c 1:8 rwm
	c 1:9 rwm
	c 1:11 rwm
	c 10:200 rwm
	c 10:235 rwm
	c 10:229 rwm
	b 182:701984 rm
	b 182:701985 rm
	b 182:700656 rmM
	b 182:700657 rmM

In this case we'd want wildcard exceptions in the child to match any of the
exceptions in the parent.


Nikolay Borisov (2):
  devcg: Move match_exception_partial before match_exception PSBM-144033
  devcg: Allow wildcard exceptions in DENY child cgroups PSBM-144033

 security/device_cgroup.c | 106 +++++++++++++++++++++++++--------------
 1 file changed, 67 insertions(+), 39 deletions(-)

--
2.34.1

