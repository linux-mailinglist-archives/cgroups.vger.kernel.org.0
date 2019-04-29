Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F30AFDB85
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2019 07:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfD2FcC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Apr 2019 01:32:02 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:40833 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfD2FcB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Apr 2019 01:32:01 -0400
Received: by mail-wr1-f41.google.com with SMTP id h4so13999848wre.7
        for <cgroups@vger.kernel.org>; Sun, 28 Apr 2019 22:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2O0PkY7e3Vk523XG+MuGevvFK5Af67Q2SEgETr+km7E=;
        b=VU30Y4i71b1E5vdQm5JcOaE4cbcImowVREVkowiOKDJn7DB5yjgDKVkfBAVSloiCMI
         2trPIzOFfZOXHYlgPyqYjxGR5tP3uEI07/OorCZLvZ83MxYrCasWkWfQAKtewwIXzjrn
         /XPJQ+RVVnuYHnCM3PdWK7EN1FKP1zkquWCnHrRaAUC4LQ9tMWnYbrbwTNAVwsoErqYt
         zoEU/Gg+jNWkLvuLCixOH0JkyxZYizwf6FCnW8uDbKXgP4ZNx7ougo8fToFTzm5vm35D
         3Hi/kgT8j4jQdAUuOsm2lSH5re8GJEu0YNZLPGPiSHfkhNRyoc41pmmtn/Wgt6TdktEC
         SbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2O0PkY7e3Vk523XG+MuGevvFK5Af67Q2SEgETr+km7E=;
        b=fXjbIk+gaTLRKyWW+Hc+GpPEOBgO3s2ej+AyhXV6zqlAH6Y2zf0jUv/Dyp6YhJcwlQ
         vmGfxbBC01dOAvcoKp5YKt2M+04w7hMYisnwNppf9JKtHbEnZH0RxmKlYXoQ4tMDKKQA
         pKPe0xJxnCkxr9uKT5vyOLbT7Pv+a4V96i8CJZqNFQwOefUeEJ+Ztdpi9TFsooxTPCwO
         e4QP9/9X3aOCc45jwYbWR2iM3Fy49OOOK1jkMaFfoLSwQKrzMFLNX4flTQKJDPmthjdc
         AnZjV7Wi9kbZ/xAkTQ2fnwtdJKR2sWhKYaG5kecsas7EdsfUkUQBIuZrG3F0Q/eYJmlf
         qrvA==
X-Gm-Message-State: APjAAAWBtwCOyHxDwzknl1aMfw+DA3nkRxaQ2sKkFG07Q+txheKaSVos
        mwOyzTHukabEyC68AcvQmJco+Sf7ox5k2I5aNljmNY1N
X-Google-Smtp-Source: APXvYqzdUorZnCKkTe5SFfcJrzHZF3xGJfV4ez/28myWY+2+c+HTGbj/j3nRrrNo4emgqeyFOC/gzkiJr5a7XoiqKeg=
X-Received: by 2002:a5d:6189:: with SMTP id j9mr10539197wru.176.1556515920187;
 Sun, 28 Apr 2019 22:32:00 -0700 (PDT)
MIME-Version: 1.0
From:   muneendra kumar <muneendra737@gmail.com>
Date:   Mon, 29 Apr 2019 11:01:49 +0530
Message-ID: <CAAhcyz=HefHnfg9jhz3W15OBgorodVXEkBR7zP_K6Xh-Mr19dA@mail.gmail.com>
Subject: Is there a way to print cgroup id from user space
To:     cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi ,
 I need to print the cgroup id info of all the cgroup that have been
created on the host.
Is there any utility to print the same.

struct cgroup {
   .......
int id;  ==> wants to print this id  info.
...
}

Regards,
Muneendra.
