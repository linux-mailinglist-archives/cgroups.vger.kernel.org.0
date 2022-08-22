Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8BE59BF49
	for <lists+cgroups@lfdr.de>; Mon, 22 Aug 2022 14:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiHVMJ5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Aug 2022 08:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiHVMJ4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Aug 2022 08:09:56 -0400
X-Greylist: delayed 353 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Aug 2022 05:09:55 PDT
Received: from digon.foursquare.net (digon.foursquare.net [216.8.179.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97EAE399F6
        for <cgroups@vger.kernel.org>; Mon, 22 Aug 2022 05:09:55 -0700 (PDT)
Received: by digon.foursquare.net (Postfix, from userid 1000)
        id 2D1E4400EC; Mon, 22 Aug 2022 08:04:02 -0400 (EDT)
Date:   Mon, 22 Aug 2022 08:04:02 -0400
From:   Chris Frey <cdfrey@foursquare.net>
To:     cgroups@vger.kernel.org
Subject: an argument for keeping oom_control in cgroups v2
Message-ID: <20220822120402.GA20333@foursquare.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_40,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In cgroups v1 we had:

	memory.soft_limit_in_bytes
	memory.limit_in_bytes
	memory.memsw.limit_in_bytes
	memory.oom_control

Using these features, we could achieve:

	- cause programs that were memory hungry to suffer performance, but
	  not stop (soft limit)

	- cause programs to swap before the system actually ran out of memory
	  (limit)

	- cause programs to be OOM-killed if they used too much swap
	  (memsw.limit...)

	- cause programs to halt instead of get killed (oom_control)

That last feature is something I haven't seen duplicated in the settings
for cgroups v2.  In terms of handling a truly non-malicious memory hungry
program, it is a feature that has no equal, because the user may require
time to free up memory elsewhere before allocating more to the program,
and he may not want the performance degredation, nor the loss of work,
that comes from the other options.

Is there a reason why it wasn't included in v2?  Is there hope that it will
come back?

Thanks,
- Chris

