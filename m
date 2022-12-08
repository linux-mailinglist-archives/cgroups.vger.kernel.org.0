Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782D864723A
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 15:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiLHOxq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Dec 2022 09:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiLHOxi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Dec 2022 09:53:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323814C271;
        Thu,  8 Dec 2022 06:53:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEB93B82432;
        Thu,  8 Dec 2022 14:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20ECFC433D6;
        Thu,  8 Dec 2022 14:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670511215;
        bh=gNYmD028duyNvaTJtvf/NGBZ2mjD2/rgX8wXO9WiHfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sD7RMyOzkU97qx+1zhDY0V/GUBCnO/9DYn4xHp6yLY4soGKny4IjRZtNBH6ylYVRT
         wdT07S9bgmuKm4z5qqy6A0RbyQcR6Y/Mo8EahGwb/MSEhdIktLivSA+tRs9E7A/QzJ
         5V1W2aO95TQsa5sHmvq7LXb1M7qQy6PfGmQCYJc0DwHE/zP8or46LDW//uoQ1JnZaB
         6dap3aBye7T6rQ6Q2s+ylr3Hr8lVtOhvzggqn58nvFRyOUdwvxHEG3c9rCDzO8V/IQ
         miQRWws2BkCY4fZl4jcatYQiOLg5d40oHHNiOseHQYNnILKj/Dcb7Uhnmu7LeOvz95
         prfaG30OOluyg==
Date:   Thu, 8 Dec 2022 14:53:24 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, zhiquan1.li@intel.com
Subject: Re: [PATCH v2 15/18] cgroup/misc: Add per resource callbacks for css
 events
Message-ID: <Y5H6ZLz7HXSaTF30@kernel.org>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-16-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202183655.3767674-16-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Dec 02, 2022 at 10:36:51AM -0800, Kristen Carlson Accardi wrote:
> Consumers of the misc cgroup controller might need to perform separate actions
> in the event of a cgroup alloc, free or release call. In addition,
> writes to the max value may also need separate action. Add the ability
> to allow downstream users to setup callbacks for these operations, and
> call the per resource type callback when appropriate.
> 
> This code will be utilized by the SGX driver in a future patch.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>

I don't know what css is.

BR, Jarkko
