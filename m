Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A5C6DDED3
	for <lists+cgroups@lfdr.de>; Tue, 11 Apr 2023 17:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDKPE5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Apr 2023 11:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDKPE4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Apr 2023 11:04:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5107E132
        for <cgroups@vger.kernel.org>; Tue, 11 Apr 2023 08:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBAA162215
        for <cgroups@vger.kernel.org>; Tue, 11 Apr 2023 15:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4965EC433A1;
        Tue, 11 Apr 2023 15:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681225495;
        bh=7WIyVeb9XzClyLWUvvV5p3kO/EMToSSNiNmVoHs1IG8=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=UzmEBprgpf9xgOEcYRkIKoBq+QSWCf/bGHsDgkUb6V2fdMIpFEyL0j0o6ljPZPwBa
         YQTt+UrK5v2pEVdRL3J7ysjasXzLREAw9iZKfZItpVbcZQEui+3wtcAphdttbOJLyj
         08MqARvVUWewD9r3dB/6kK87s7pc7dNGRZKUO2No+BHElV2GB3dvOcfrdRMM/kpuRY
         bqj8RcOLVTkIvwaXHeNLbOMDveS8OBghipvoLgQF4ve9TDA8GkYJ9chyS/Rk1+MKbM
         wn7Wmo9SmteSvtWMLFkVR8Ry46yiDTCgIqRzwVSuUkkFmzxChrOOxKFd+DjOOxNHOS
         dxzi9XKOePnyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32883E52441;
        Tue, 11 Apr 2023 15:04:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From:   "Kernel.org Bugbot" <bugbot@kernel.org>
To:     tj@kernel.org, bugs@lists.linux.dev, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, lizefan.x@bytedance.com
Message-ID: <20230411-b217305c1-d58d491bf9b5@bugzilla.kernel.org>
In-Reply-To: <20230411-b217305c0-44d643ccee27@bugzilla.kernel.org>
References: <20230411-b217305c0-44d643ccee27@bugzilla.kernel.org>
Subject: Re: When processes are forked using clone3 to a cgroup in cgroup
 v2 with a specified cpuset.cpus, the cpuset.cpus doesn't take an effect to
 the new processes
X-Bugzilla-Product: Linux
X-Bugzilla-Component: Kernel
X-Mailer: peebz 0.1
Date:   Tue, 11 Apr 2023 15:04:55 +0000 (UTC)
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_FROM_NAME_TO_DOMAIN,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tcao34 added a new attachment via Kernel.org Bugzilla.
You can download it by following the link below.

File: config-6.3.0-rc5-master (text/plain)
Size: 266.54 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=304089
---
Config file we used

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (peebz 0.1)

