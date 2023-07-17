Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFCA75642F
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 15:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjGQNRI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 09:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjGQNQw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 09:16:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8FC2713;
        Mon, 17 Jul 2023 06:16:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9FF461063;
        Mon, 17 Jul 2023 13:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EC6C433C8;
        Mon, 17 Jul 2023 13:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689599768;
        bh=yX5VD4argzEiOYVVZ5od4hN9Yb9EkGyUcdTxKzHkZWU=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Yv6zBWBYNM+sft7PEHdXi84Pv8RrkBtUbsBGNXVdel9FV09PWDVdkMJ6pebKorOGO
         K1KrFHyH4CJpBdELg4D2uEadYShlllNoHSKyJykPf5VGkeww4I6PN87EeIbTAfxoHf
         jbsz60Lzztz4ubmgxEa9/oDHbIZQN/9uxIDE1qBYYXzQeyEMJxg4APVq5OE2+plftT
         4Tbl80up8rDQrlY1A1gj2DIguS8mR2aHlDR+RnZtjkAoyiSt5bhzUpDueb2Z3pBY5l
         YdArnWftCLSItCTwW5IPZwspVX+BAeJE3ckvPK+kc1G8pe2yk12IJ6Q9iKiS4HL70L
         rUMU9bmfVHPDg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Jul 2023 13:16:04 +0000
Message-Id: <CU4H4O6WHRY2.2Q6YGBQQFJBK5@seitikki>
Cc:     <kai.huang@intel.com>, <reinette.chatre@intel.com>,
        "Kristen Carlson Accardi" <kristen@linux.intel.com>,
        <zhiquan1.li@intel.com>
Subject: Re: [PATCH v3 19/28] cgroup/misc: Add per resource callbacks for
 CSS events
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <cgroups@vger.kernel.org>, "Zefan Li" <lizefan.x@bytedance.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>
X-Mailer: aerc 0.14.0
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-20-haitao.huang@linux.intel.com>
In-Reply-To: <20230712230202.47929-20-haitao.huang@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed Jul 12, 2023 at 11:01 PM UTC, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> Consumers of the misc cgroup controller might need to perform separate
> actions for Cgroups Subsystem State(CSS) events: cgroup alloc and free.
> In addition, writes to the max value may also need separate action. Add
> the ability to allow downstream users to setup callbacks for these
> operations, and call the corresponding per-resource-type callback when
> appropriate.
>
> This code will be utilized by the SGX driver in a future patch.
>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>

Ditto. Belongs to the head of the patch set.

BR, Jarkko
