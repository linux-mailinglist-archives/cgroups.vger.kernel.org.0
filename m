Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BD175630D
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 14:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjGQMrI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 08:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGQMrH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 08:47:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E3B9D;
        Mon, 17 Jul 2023 05:47:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF39161050;
        Mon, 17 Jul 2023 12:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0A9C433C7;
        Mon, 17 Jul 2023 12:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689598026;
        bh=DckZWJU+9gB0L1R/ZazMtJ82YVYplEoWf3KaQjLD6dY=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=GxFhbOoWkaE8XZyWfTeqyPcRuUGAo7XO5YYNV4wiIjXf+UQYXXFmI/KUEe72128DU
         +Rcv139B2DGaOv6ot7waQgcCAaiPXwh5xSMOCusTNRuc/hVic77IkbSJdlCTC+Ngkf
         DP+mDEClHLiI07zTH2TQbyufugHQj2Or4TZm+xwsCbFlMR5Vn4nrITxUbgbr0n5oF8
         QaSj1YmA+IYosxwf1y3VsgXT4THX2GmQwALrk5fLlOJ4h6pp+JiF2rjIhMxuf4w9uu
         hyovDYvjyLTYV/etju2l1z9rXwaBMOnuGSP5eSg/wPikX8QX3AFZx/a83tmDwOJNCI
         7+6Ucre9E1eXQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Jul 2023 12:47:01 +0000
Message-Id: <CU4GIFHMTA8N.2GV3WIA7HAVOE@seitikki>
Cc:     <kai.huang@intel.com>, <reinette.chatre@intel.com>,
        "Kristen Carlson Accardi" <kristen@linux.intel.com>,
        <zhiquan1.li@intel.com>, <seanjc@google.com>
Subject: Re: [PATCH v3 04/28] x86/sgx: Use sgx_epc_lru_lists for existing
 active page list
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <cgroups@vger.kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: aerc 0.14.0
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-5-haitao.huang@linux.intel.com>
In-Reply-To: <20230712230202.47929-5-haitao.huang@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed Jul 12, 2023 at 11:01 PM UTC, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> Replace the existing sgx_active_page_list and its spinlock with
> a global sgx_epc_lru_lists struct.

Similarly as the previous patch, I would extend this story a tiny
bit forward to see the connection with the follow-up patches.

BR, Jarkko
