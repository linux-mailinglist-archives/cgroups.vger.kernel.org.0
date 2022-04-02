Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9144F05BF
	for <lists+cgroups@lfdr.de>; Sat,  2 Apr 2022 21:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiDBTZd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 2 Apr 2022 15:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiDBTZb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 2 Apr 2022 15:25:31 -0400
X-Greylist: delayed 346 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Apr 2022 12:23:37 PDT
Received: from mta-out-06.alice.it (mta-out-06.alice.it [217.169.118.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF51FDB4
        for <cgroups@vger.kernel.org>; Sat,  2 Apr 2022 12:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alice.it; s=20211207; t=1648927417; 
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        h=Reply-To:From:To:Date:Message-ID:MIME-Version;
        b=wzdlw9nmZpqy3OJxlWKlO8Vyi/YBZHrDZLQXX48q3HUqL0NSYDnbSwJO/xKqqDjKUCza+xo2kjBD/2efbPejHf865CyDb2xYMWfXM1NIq46SEG8uIeGRG62SxF1Z7nE+K3YchnEQGhz2D4IlrvAYCIl2QKQBtIi1rG9oT6f7gqA2IMQgf5VIUESBxY7M9rl76amm+AKCBkDZFtSjchLO584RuJ6RNTSn+g+MlQfMeDvihX1fKDsOoOeFFOOD2vdC/h7iyhbRZNw8VDCTZWj0/w+KVvRGzfoiOkRbu5h/BnSQzXWB+HFuExtA5KhUQWi4RHiGerHsnpHm6uzb6cR5Cg==
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrudeikedgudefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfvgffngfevqffokffvtefnkfetpdfqfgfvnecuuegrihhlohhuthemuceftddunecugfhmphhthicushhusghjvggtthculddutddmnefgmhhpthihucgsohguhiculdehtddmnecujfgurheprhfhvfffkfggsedttdeftddttddtnecuhfhrohhmpeghvgcuhhgrvhgvucgrnhcuohhffhgvrhcuthhouchinhhvvghsthcuihhnucihohhurhcutghouhhnthhrhicuuhhnuggvrhcurgcujhhoihhnthcuvhgvnhhtuhhrvgcuphgrrhhtnhgvrhhshhhiphcuphhlvggrshgvuchrvghplhihuchfohhruchmohhrvgcuuggvthgrihhlshcuoehfpghpvghnnhgrsegrlhhitggvrdhitheqnecuggftrfgrthhtvghrnhepheejteeghfelteeitdekleffgfejueeggeelkeeufffggedtkeekieefvddvffetnecukfhppedujeeirddvvdejrddvgedvrdduledtnecuvehluhhsthgvrhfuihiivgepieelkeenucfrrghrrghmpehhvghloheprghlihgtvgdrihhtpdhinhgvthepudejiedrvddvjedrvdegvddrudeltddpmhgrihhlfhhrohhmpehfpghpvghnnhgrsegrlhhitggvrdhithdpnhgspghrtghpthhtohepuddprhgtphhtthhopegtghhrohhuphhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 60
X-RazorGate-Vade-Classification: clean
Received: from alice.it (176.227.242.190) by mta-out-06.alice.it (5.8.807.04) (authenticated as f_penna@alice.it)
        id 623C9D2100DAFF76 for cgroups@vger.kernel.org; Sat, 2 Apr 2022 21:17:47 +0200
Reply-To: dougfield20@inbox.lv
From:   We have an offer to invest in your country under a
         joint venture partnership please reply for more
         details <f_penna@alice.it>
To:     cgroups@vger.kernel.org
Date:   02 Apr 2022 12:17:45 -0700
Message-ID: <20220402121745.09015155E8209996@alice.it>
MIME-Version: 1.0
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,BODY_EMPTY,
        DKIM_INVALID,DKIM_SIGNED,EMPTY_MESSAGE,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,MISSING_SUBJECT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5072]
        * -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/,
        *       low trust
        *      [217.169.118.12 listed in list.dnswl.org]
        *  0.0 RCVD_IN_MSPIKE_L3 RBL: Low reputation (-3)
        *      [217.169.118.12 listed in bl.mailspike.net]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [f_penna[at]alice.it]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dougfield20[at]inbox.lv]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.3 EMPTY_MESSAGE Message appears to have no textual parts and no
        *      Subject: text
        *  1.8 MISSING_SUBJECT Missing Subject: header
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        *  0.0 RCVD_IN_MSPIKE_BL Mailspike blacklisted
        *  0.0 BODY_EMPTY No body text in message
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

