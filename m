Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06A46C8DB8
	for <lists+cgroups@lfdr.de>; Sat, 25 Mar 2023 12:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCYL7l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 25 Mar 2023 07:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYL7k (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 25 Mar 2023 07:59:40 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2699212CDD
        for <cgroups@vger.kernel.org>; Sat, 25 Mar 2023 04:59:40 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id le6so4114399plb.12
        for <cgroups@vger.kernel.org>; Sat, 25 Mar 2023 04:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679745579;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CY9AsorMV2lTcvatQ9gGcropbDgZAywplz6MLboUuMk=;
        b=WBV2AuLXrYAkKSilPZtWPmO04/Qhn+yXFRFMGKKStQE3mbT97rqhg94AXvZ3CzUHEC
         CornOfmKUawdMp2Z6SGJ9fQyTfOzaLQ9PxuGoc6LZTW7o/zsn0B2RcUREQ//S3NPMUuH
         56I/UB44OKU9zhH5evLhBv5WK5WQHTzLyHqSkPI6mVbjB+ySQhWJNL4Zvu1yUgfuk8Xl
         93McwZ3VuVQXQQhARbeNkofCU417YiHw1mHc7feAB8yGvMNpwTIo/UbbzsfxYf1r2+yr
         SbarZJWFDmXy7WGhMmVfPWXp9J9lPWi1mKqOJY9UUEBSFAZxHaen7LsrFe/u+d+9K2xV
         HhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679745579;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CY9AsorMV2lTcvatQ9gGcropbDgZAywplz6MLboUuMk=;
        b=VbvujHGTvsjk1KWWkU/C8fyCds9KnG8qUeJZaMcNAR3Q9XxFveMvTIiNSk2Dqua1XI
         bUJAnXdlFkq6T6KJRLCkWEhLEriifdNmTxJ4tjVBjOrvgIpjwCEOrzFGk+v8VDQy5CIE
         ZVWu9e47NL7qlIH36LPk0d5IrMXqcgSHGTpvgSRjJur7rYOIO2NXExBQUjGKRDYnrZsb
         3hsJHBMhQNL6CXMhlrnzuCmeFuNHDXd6ryobWQ9rewL5Z6qoDNwzs7RXYGX5N5XAGVZg
         MQuKgn6YSQlRabSCE0F2A/cGJhU7U3n4+bzX4f73HCuBFUZvW77xGM3fHMqSgJ9TboRC
         pBiQ==
X-Gm-Message-State: AAQBX9dgy1qk2QhMFDrrYTL6e2AQqIw7EIu7fXYrUE+OEvOuJjcgqQkw
        LZUG/XGFHJcpXbyLevkyNu3G3xC07gVpfGYTqQA=
X-Google-Smtp-Source: AKy350bXzFhIAVDfy4gDIzqIO9rVVdt/485Znk5j2MySoBlzOVOBI/cMVHnwRNjaGxfAHKGaPriL/WKm/Cpp/pAJbQ8=
X-Received: by 2002:a17:90a:c083:b0:240:30ec:f7b with SMTP id
 o3-20020a17090ac08300b0024030ec0f7bmr1761517pjs.7.1679745579626; Sat, 25 Mar
 2023 04:59:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:b2a3:b0:da:1143:23c0 with HTTP; Sat, 25 Mar 2023
 04:59:39 -0700 (PDT)
Reply-To: hitnodeby23@yahoo.com
From:   Hinda Itno Deby <diaboagifty@gmail.com>
Date:   Sat, 25 Mar 2023 04:59:39 -0700
Message-ID: <CAKiJAOFeVupxtHyHrD+osRUdqpsM6FsvkrtvYaLboBieorV8NA@mail.gmail.com>
Subject: Reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM,UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [diaboagifty[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [hitnodeby23[at]yahoo.com]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:62c listed in]
        [list.dnswl.org]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.9 URG_BIZ Contains urgent matter
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

-- 
Hello Dear

My name is Hinda Itno Deby Please I want us to discuss Urgent Business
Proposal, if you are interested kindly reply to me so i can give you
all the details.

Thanks and God Bless You.
Ms Hinda Itno Deby
