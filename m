Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3130074D506
	for <lists+cgroups@lfdr.de>; Mon, 10 Jul 2023 14:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjGJMNy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jul 2023 08:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjGJMNx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jul 2023 08:13:53 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB01E103
        for <cgroups@vger.kernel.org>; Mon, 10 Jul 2023 05:13:50 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-579dfae6855so55563907b3.1
        for <cgroups@vger.kernel.org>; Mon, 10 Jul 2023 05:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688991229; x=1691583229;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/2RlxWlOhJbOFxHHiWp08TsyEu+zJrfP5HNHS/WQHJU=;
        b=ZrtuuJCsjTfmUcUsHuz0dbtW+Zln8RaxXmvyy4YP4nL0yXeDl8sIW3TDHvoQ5gOCOW
         OFaUKa/Sw1QdsX2RFD4AqJPwJdQrLH36mU6kZkasRaXfmkzgpK30dx/eN4qHAPyKjV7G
         PFYqzVdupr81Biq5vlH8jdzv1c6bgX8w0xQqe8inWtiOygOlGUJ3zk+PEoqe3MakIioR
         bcCr3D+fdRgokSxgRLnZN9/sA57lVRMTowDG6YyIcoydqmB1W694766r2e/UDvntf7vb
         8277MLycSmQ0fJSyf8JTlKlXAKfWgtKsv5vkNVvgx0MY/7/jSvHXqzLsPP2NWfXKcpp5
         FmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688991229; x=1691583229;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2RlxWlOhJbOFxHHiWp08TsyEu+zJrfP5HNHS/WQHJU=;
        b=hwW3docOtf0iPEuXrESe/wB1eX8OSNaOWaT3IFxgxrg8Zs6v7/Np+ip9zn1dNO3O9k
         D84z3hzZVcMjYX+rHhpKpTpRqtHZvs/AZlZPJCGcfCYao04Gq/OubaPQ7hGjqQo4z54J
         8AAJmtPENkhg0BaqpniroONDj8hyLSitUktjA275X3/WQXwfZIg26sLiCeOxNcoHxuUI
         y0QmDsXwg1er1/iz8Dt0z3YX1LdibTaOQ16UCIynE/ZiFMaysbLIiN+E5bRnfhAc7lyl
         vC1fXHJ7bCiqRhIK3jle73edrBY9/3oP637senH+tqH9w7PU0y+9HeT/H2lplZ1j81Ar
         tLOA==
X-Gm-Message-State: ABy/qLZZDC60be4aIaPOXNOpb1wedaPiVIZ8+WoKrFgegiwRnp08jUcv
        lLqabLtQU6ocj0xgEch6wXNBnUf/sy/ReuPs6A==
X-Google-Smtp-Source: APBJJlHLhnhf0QhnNJYLu5xY3iuyH8X80gNbJyEcay2M4TUpLhQYZO6okguN6M7sy9uPhQ5hHZrKH5EbtXGWr1VIEKQ=
X-Received: by 2002:a81:4f58:0:b0:576:93f1:d118 with SMTP id
 d85-20020a814f58000000b0057693f1d118mr12033707ywb.2.1688991229673; Mon, 10
 Jul 2023 05:13:49 -0700 (PDT)
MIME-Version: 1.0
Reply-To: salkavar78@gmail.com
Sender: penelopeliam84@gmail.com
Received: by 2002:a05:7108:520d:b0:2f8:6076:7715 with HTTP; Mon, 10 Jul 2023
 05:13:49 -0700 (PDT)
From:   "Mr. Sal Kavar" <salkavar78@gmail.com>
Date:   Mon, 10 Jul 2023 05:13:49 -0700
X-Google-Sender-Auth: iLm7vyq_3M__xJ1K5hJt6NJPdR0
Message-ID: <CAFeAMsRhh7t-jr-dq7aCDgu1uJ7vkfBO9jdbQymSDWnYLrfzOQ@mail.gmail.com>
Subject: Yours Faithful,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MILLION_HUNDRED,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:1133 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5045]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [penelopeliam84[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [salkavar78[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [penelopeliam84[at]gmail.com]
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.6 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

I assume you and your family are in good health.

Overdue and unclaimed sum of $15.5m, (Fifteen Million Five Hundred
Thousand Dollars Only) when the account holder suddenly passed on, he
left no beneficiary who would be entitled to the receipt of this fund.

Yours Faithful,
Mr.Sal Kavar.
