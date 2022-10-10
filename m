Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82855F9B7A
	for <lists+cgroups@lfdr.de>; Mon, 10 Oct 2022 10:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiJJI5a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 04:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiJJI5a (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 04:57:30 -0400
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175A5631CA
        for <cgroups@vger.kernel.org>; Mon, 10 Oct 2022 01:57:29 -0700 (PDT)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-1364357a691so5276601fac.7
        for <cgroups@vger.kernel.org>; Mon, 10 Oct 2022 01:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXUl3DqLFbTtFtCoMEclQM3ZbKkw2ZlACbyEiXC/hso=;
        b=EqSzkZtsf1yX3BnomQvJNepwXowKD71I29ap08rnmBkb/g/8E/NjKb10a6bqJnX4hQ
         7tzfMrkPOdOCrP9MXm8TmIKlaQMIFWtOckWuuRtQ4yIdNzYxZQZZ3MTBMqzkXd41gj/T
         1bh542MWi5V6Mg/VGIGkldMrbQlEJgVw18qb3zoa0xv72UjuZwFcpoyr2X3Kwnt4vbsL
         4vE7sMIG9Oh3+ylbPW9Wx5QxINzZsbYGFo0+/RvEktYFQuMKUZurEEVbWUi7CcDgDJCU
         fVolloIEXkpZZK/sMGK3z5kDKMUkPJFl9Wy4ABzJO3DsNsIasitCBzqHkW5HRJiym8hR
         /ZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXUl3DqLFbTtFtCoMEclQM3ZbKkw2ZlACbyEiXC/hso=;
        b=254R1T7b/mBFf2dGrdYg0z92u28z57o/Beur00T4K2rawQnbc4lOe2j12W+HKrFmNP
         OrJSgAvoPSF+n12WbqEapBeu4/3gGwVwvcgwqFhe1kZOrS0bcAS0JNmUEjCumla5YpnE
         RxStgpzSMPcSNF1Ibd4aPOPFM8srD2WCHuBNnHgdA8yenqDLG5uXAjmpdbKKFG+kJQWd
         pdC01VMWkfExFwQAu9Gj4HJFyN82jvHYKvvGVlq0nNPRiXvGlI8EZVh4Oi00Nll9pmaZ
         /5lM5RoMIla9IHcN7lCwCmiTRPzEQZQYDOm9xp62zGzJ6H+rCbhrLmru/osJlLK5GoQ+
         jqRA==
X-Gm-Message-State: ACrzQf1Szp6CZ+BLL6/UqwWnXLzCF9UiIjISL/VcN4tZVTG0grnmURA4
        pAd8wi/V509q4uUp2bbndRZjH0QhqyzVrALU0j8=
X-Google-Smtp-Source: AMsMyM79FgDFgjgF/ToFS6p9w+oWtgx00PiWkgNHEkqmGBQkIBgAHaYkKoB9si9kwolA1qublICfbY7nyAFl774Pme8=
X-Received: by 2002:a05:6870:1496:b0:132:2020:9c8d with SMTP id
 k22-20020a056870149600b0013220209c8dmr9297804oab.78.1665392248391; Mon, 10
 Oct 2022 01:57:28 -0700 (PDT)
MIME-Version: 1.0
Sender: mohammeddrashok@gmail.com
Received: by 2002:a05:6838:ac92:0:0:0:0 with HTTP; Mon, 10 Oct 2022 01:57:28
 -0700 (PDT)
From:   Ibrahim idewu <ibrahimidewu4@gmail.com>
Date:   Mon, 10 Oct 2022 09:57:28 +0100
X-Google-Sender-Auth: Gg0eQXAhVsYYjDZnVRBrEdyZhF4
Message-ID: <CAL=ghb7jmU9wWrfpMnuZaSfGMpipWT7QPm9+paUL484aai=7EA@mail.gmail.com>
Subject: I Need Your Respond
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.0 required=5.0 tests=ADVANCE_FEE_5_NEW_FRM_MNY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MONEY_FORM,
        MONEY_FRAUD_8,NA_DOLLARS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_MONEY_PERCENT,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:44 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5233]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ibrahimidewu4[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 NA_DOLLARS BODY: Talks about a million North American dollars
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.8 HK_SCAM No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  0.0 MONEY_FORM Lots of money if you fill out a form
        *  2.8 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  0.0 ADVANCE_FEE_5_NEW_FRM_MNY Advance Fee fraud form and lots of
        *      money
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

HELLO..,

My name is Mr. Ibrahim Idewu, I work in the bank here in Burkina faso.
I got your contact
from internet search i hope that you will not expose or betray this
trust and confident that am about to entrust in you for the benefit of
our both families.

I discovered an abandoned fund here in our bank belonging to a dead
businessman who lost his life and entire family in a motor accident,
I am in need of your help as a foreigner to present you as the next of
kin and to transfer the
sum of $19.3 million U.S dollars (nineteen. Three million U.S dollars) into your
account risk is completely %100 free.

This is paid or shared in these percentages, 60% for me and 40% for
you. I have secured legal documents that can be used to substantiate
this claim. The only thing I have to do is put your names in the
documents and legalize them here in court to prove you as the rightful
beneficiary. All I need now is your honest cooperation,
confidentiality and your trust, so that we can complete this
transaction. I guarantee that this transaction is 100% risk-free, as
the transfer is subject to international banking law

Please give me this as we have 5 days to work through this. This is very urgent.

1. Full Name:
2. Your direct mobile number:
3. Your contact address:
4. Your job:
5. Your nationality:
6. Your gender / age:

Please confirm your message and interest to provide further
information. Please do get back to me on time.

Best regards
Mr. Ibrahim idewu
