Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC041A1F9A
	for <lists+cgroups@lfdr.de>; Wed,  8 Apr 2020 13:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgDHLMQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Apr 2020 07:12:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44834 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbgDHLMQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Apr 2020 07:12:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id i16so8046953edy.11;
        Wed, 08 Apr 2020 04:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=y6GvbrxPWO38NZY2qniHG/bjP2NH5oiIBjc+DHthlNY=;
        b=VC5psAUsa1U2CjvoshCFasg2IK8FzsljYRvZ/5QS60xwoyvFBFXQqmt8BkfUpV3HhM
         wkeRFEaLVqKQIOoZDyHNzLICNc4pgkurJGaKqWSZfacFmPdK86yd+dxBZVQCpzJjJOcA
         nPceEZnTYX6NJHBHq5pJAT/x9+LSQWopr7Q1En9TwCbD3g2D35OpQY+2TajCjUF+FN1e
         1nx+MN0TVjZJqCRqNbYlmm5rP8MdMkc4y6G74Frt5V7HwMBNMWLyd3BYzC8p66tFBOa3
         x+m/N/xyM5Zel3thnTh3qMXI0vUG6+MDW4TbGn4BkVcNFBi01WQ7mnKcOKPmwSSniwZC
         8YFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=y6GvbrxPWO38NZY2qniHG/bjP2NH5oiIBjc+DHthlNY=;
        b=KATwr8QcNWNVC17uOY0M097ufa1HW4BjNA/CHKemVGQ+B+B+QlCxpnEuI8oTsvM1sI
         akkq+HccgM/gIK+0ceqsMikHRXbZsSBfEu6zhJED1nVa8BZ5cmkOqQlFsLFgC6p3VL1t
         EN9t87EpXPYq1VLJkrcNMWLgSENaszTCZkODgDgP8pNvL0AeHrIGrIgeQJC97JB7wxx7
         2yJV/b8pLVmIZxokEXdlRcEt0KJwOVssNbI6rUjfph8GBI2WtFgurP0+Iqygzc6cFVcr
         1yP5CCHZ4FKYJlKDBEMs6IzJZW+BfAyzX9oRC5fTYWs2lz+jJaqbrn28igtS1A+EKvft
         eAdA==
X-Gm-Message-State: AGi0PuatYKpvWs2X0cbR1FJHA2ZSwgn35gQ0EbGMuFaCCYjJr2I33nzm
        hCtTECG8UwX8vtJ/UnUzso9vRZEpwgHDERFmT90=
X-Google-Smtp-Source: APiQypLakffEooTTK/wIZhPA1UXmX6ePrOgYPFpT6bdDI4nYEdoKNBKYdrg7FinZZVq0sJNuwRcasB3azLK159CjdFg=
X-Received: by 2002:a05:6402:504:: with SMTP id m4mr6031207edv.367.1586344332475;
 Wed, 08 Apr 2020 04:12:12 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Wed, 8 Apr 2020 13:12:01 +0200
Message-ID: <CAKgNAkhL0zCj11LS9vfae872YVeRsxdz20sZWuXdi+UjH21=0g@mail.gmail.com>
Subject: CLONE_INTO_CGROUP documentation?
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Christian,

I see that CLONE_INTO_CGROUP has been merged? WOuld you be able to
send a man-pages patch documenting this please?

Thanks,

Michael


--
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
